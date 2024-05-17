import 'package:equatable/equatable.dart';
import '../../models/post_model.dart';

abstract class LikeState extends Equatable {}

class LikeInitialState extends LikeState {
  @override
  List<Object?> get props => [];
}

class LikeErrorState extends LikeState {
  final String message;

  LikeErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class LikeLoadingState extends LikeState {
  @override
  List<Object?> get props => [];
}

class LikeLoadLikesState extends LikeState {
  final List<Post> posts;

  LikeLoadLikesState(this.posts);

  @override
  List<Object?> get props => [];
}