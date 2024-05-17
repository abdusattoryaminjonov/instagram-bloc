
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {

  @override
  List<Object?> get props => [];
}

class HomePageChangedState extends HomeState{
  final int index;

  HomePageChangedState(this.index);

  @override
  List<Object?> get props => [];
}

class HomeAnimatedToPageState extends HomeState{
  final int currentTap;
  final PageController pageController;

  HomeAnimatedToPageState(this.currentTap, this.pageController);

  @override
  List<Object?> get props => [currentTap, pageController];
}
