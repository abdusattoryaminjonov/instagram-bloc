import 'package:equatable/equatable.dart';

abstract class LikeEvent extends Equatable {}

class LikeLoadLikesEvent extends LikeEvent {
  @override
  List<Object?> get props => [];
}