import 'package:equatable/equatable.dart';
import '../../models/post_model.dart';

abstract class FeedState extends Equatable {}

class FeedInitialState extends FeedState {
  @override
  List<Object?> get props => [];
}

class FeedErrorState extends FeedState {
  final String message;

  FeedErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class FeedLoadingState extends FeedState {
  @override
  List<Object?> get props => [];
}

class FeedLoadPostState extends FeedState {
  final List<Post> posts;

  FeedLoadPostState(this.posts);

  @override
  List<Object?> get props => [];
}