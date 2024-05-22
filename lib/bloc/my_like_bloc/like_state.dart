
import '../../models/post_model.dart';

abstract class MyLikeState {}

class MyLikeInitialState extends MyLikeState {}

class MyLikeLoadingState extends MyLikeState {}

class MyLikeSuccessState extends MyLikeState {
  List<Post> items;

  MyLikeSuccessState({required this.items});
}

class MyLikeFailureState extends MyLikeState {
  final String errorMessage;

  MyLikeFailureState(this.errorMessage);
}
class UnLikePostSuccessState extends MyLikeState {
  Post post;

  UnLikePostSuccessState({required this.post});

  @override
  List<Object?> get props => [post];
}
