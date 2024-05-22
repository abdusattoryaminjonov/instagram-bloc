import 'package:equatable/equatable.dart';

abstract class MyFeedEvent extends Equatable {
  const MyFeedEvent();
}

class LoadFeedPostsEvent extends MyFeedEvent {
  @override
  List<Object> get props => [];
}