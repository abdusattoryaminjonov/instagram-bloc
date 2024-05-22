import 'package:flutter/material.dart';

abstract class HomeEvent {}

class BottomNavEvent extends HomeEvent {
  int currentIndex;

  BottomNavEvent({required this.currentIndex});
}

class PageViewEvent extends HomeEvent {
  int currentIndex;

  PageViewEvent({required this.currentIndex});
}