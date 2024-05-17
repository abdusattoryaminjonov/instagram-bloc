import 'package:equatable/equatable.dart';

import '../../../models/post_model.dart';

abstract class ItemPostState extends Equatable {
  const ItemPostState();
}

class ItemPostInitialState extends ItemPostState {
  @override
  List<Object?> get props => [];
}

class ItemPostLoadingState extends ItemPostState {
  @override
  List<Object?> get props => [];
}

class LikePostState extends ItemPostState {
  final Post post;

  const LikePostState(this.post);

  @override
  List<Object?> get props => [post];
}

class UnlikePostState extends ItemPostState {
  final Post post;

  const UnlikePostState(this.post);

  @override
  List<Object?> get props => [post];
}

class RemovePostState extends ItemPostState {
  @override
  List<Object?> get props => [];
}