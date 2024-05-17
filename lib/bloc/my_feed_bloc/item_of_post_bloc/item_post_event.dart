import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/post_model.dart';

abstract class ItemPostEvent extends Equatable {
  const ItemPostEvent();
}

class LikePostEvent extends ItemPostEvent {
  final Post post;

  const LikePostEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class UnlikePostEvent extends ItemPostEvent {
  final Post post;

  const UnlikePostEvent(this.post);

  @override
  List<Object?> get props => [post];
}

class RemovePostEvent extends ItemPostEvent {
  final BuildContext context;
  final Post post;

  const RemovePostEvent(this.context, this.post);

  @override
  List<Object?> get props => [post];
}