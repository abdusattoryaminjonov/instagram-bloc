import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/member_model.dart';
import '../../../services/db_service.dart';
import '../../../services/http_service.dart';
import '../../../services/utils_service.dart';
import '../feed_bloc.dart';
import '../feed_event.dart';
import 'item_post_event.dart';
import 'item_post_state.dart';

class ItemPostBloc extends Bloc<ItemPostEvent, ItemPostState> {
  ItemPostBloc() : super(ItemPostInitialState()) {
    on<LikePostEvent>(apiPostLike);
    on<UnlikePostEvent>(apiPostUnLike);
    on<RemovePostEvent>(dialogRemovePost);
  }

  Future<void> apiPostLike(LikePostEvent event, Emitter<ItemPostState> emit) async {
    emit(ItemPostLoadingState());

    await DBService.likePost(event.post, true);

    event.post.liked = true;
    emit(LikePostState(event.post));

    var owner = await DBService.getOwner(event.post.uid);
    sendNotificationToLikedMember(owner);
  }

  void sendNotificationToLikedMember(Member someone) async {
    Member me = await DBService.loadMember();
    await Network.POST(Network.API_SEND_NOTIF, Network.notifyLike(me, someone));
  }

  Future<void> apiPostUnLike(
      UnlikePostEvent event, Emitter<ItemPostState> emit) async {
    emit(ItemPostLoadingState());

    await DBService.likePost(event.post, false);
    event.post.liked = false;
    emit(UnlikePostState(event.post));
  }

  Future<void> dialogRemovePost(
      RemovePostEvent event, Emitter<ItemPostState> emit) async {
    var result = await Utils.dialogCommon(
      event.context,
      "Instagram",
      "Do you want to delete this post?",
      false,
    );

    if (result) {
      emit(ItemPostLoadingState());

      DBService.removePost(event.post).then(
              (value) => {event.context.read<FeedBloc>().add(FeedLoadPostEvent())});
    }
  }
}