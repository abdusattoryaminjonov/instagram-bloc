import 'package:bloc/bloc.dart';
import 'package:instaclon/bloc/my_like_bloc/like_event.dart';
import 'package:instaclon/bloc/my_like_bloc/like_state.dart';

import '../../models/post_model.dart';
import '../../services/db_service.dart';

class MyLikeBloc extends Bloc<MyLikeEvent,MyLikeState> {
  List<Post> items = [];

  MyLikeBloc() : super(MyLikeInitialState()) {
    on<LikeLoadLikesEvent>(_onLikeLoadLikesEvent);
    on<UnLikePostEvent>(_onUnLikePostEvent);
  }

  Future<void> _onLikeLoadLikesEvent(LikeLoadLikesEvent event, Emitter<MyLikeState> emit) async {
    emit(MyLikeLoadingState());

    var result = await DBService.loadLikes();
    items = result;

    if (result.isNotEmpty) {
      emit(MyLikeSuccessState(items: items));
    } else {
      emit(MyLikeFailureState("No data"));
    }

  }

  Future<void> _onUnLikePostEvent(UnLikePostEvent event, Emitter<MyLikeState> emit) async {
    await DBService.likePost(event.post, false);
    event.post.liked = false;
    emit(UnLikePostSuccessState(post: event.post));
  }

}