import 'package:bloc/bloc.dart';
import 'package:instaclon/bloc/my_like_bloc/like_event.dart';
import 'package:instaclon/bloc/my_like_bloc/like_state.dart';

import '../../models/post_model.dart';
import '../../services/db_service.dart';

class LikeBloc extends Bloc<LikeEvent,LikeState> {
  List<Post> items = [];

  LikeBloc() : super(LikeInitialState()) {
    on<LikeLoadLikesEvent>(_apiLoadLikes);
  }

  Future<void> _apiLoadLikes(LikeLoadLikesEvent event, Emitter<LikeState> emit) async {
    emit(LikeLoadingState());

    var result = await DBService.loadLikes();
    items = result;

    emit(LikeLoadLikesState(items));
  }
}