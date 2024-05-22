import 'package:equatable/equatable.dart';

import '../../models/post_model.dart';

abstract class MyLikeEvent extends Equatable {
  const MyLikeEvent();
}

class LikeLoadLikesEvent extends MyLikeEvent {
  @override
  List<Object> get props => [];
}
class UnLikePostEvent extends MyLikeEvent {
  Post post;

  UnLikePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}