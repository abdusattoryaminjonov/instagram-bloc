import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable{

}

class SplashWaitEvent extends SplashEvent {
  @override
  List<Object?> get props => [];

}