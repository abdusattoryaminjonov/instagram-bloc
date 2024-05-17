import 'package:bloc/bloc.dart';

import '../../models/post_model.dart';
import '../../services/db_service.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  List<Post> items = [];

  FeedBloc() : super(FeedInitialState()) {
    on<FeedLoadPostEvent>(_apiLoadFeeds);
  }

  Future<void> _apiLoadFeeds(FeedLoadPostEvent event, Emitter<FeedState> emit) async {
    emit(FeedLoadingState());

    var result = await DBService.loadFeeds();
    items = result;

    emit(FeedLoadPostState(items));
  }
}