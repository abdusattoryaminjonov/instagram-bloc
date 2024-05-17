import 'package:equatable/equatable.dart';

abstract class FeedEvent extends Equatable {}

class FeedLoadPostEvent extends FeedEvent {
  @override
  List<Object?> get props => [];
}