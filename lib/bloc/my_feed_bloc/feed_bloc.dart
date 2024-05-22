
import 'package:bloc/bloc.dart';

import '../../services/db_service.dart';
import 'feed_event.dart';
import 'feed_state.dart';

class MyFeedBloc extends Bloc<MyFeedEvent, MyFeedState> {
  MyFeedBloc() : super(MyFeedInitialState()) {
    on<LoadFeedPostsEvent>(_onLoadPostsEvent);
  }

  Future<void> _onLoadPostsEvent(LoadFeedPostsEvent event, Emitter<MyFeedState> emit) async {
    emit(MyFeedLoadingState());

    var items = await DBService.loadFeeds();

    if (items.isNotEmpty) {
      emit(MyFeedSuccessState(items: items));
    } else {
      emit(MyFeedFailureState("No data"));
    }
  }
}