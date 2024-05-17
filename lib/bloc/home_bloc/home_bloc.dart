import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  PageController? pageController;
  int currentTap = 0;

  HomeBloc() : super(HomeInitialState()) {
    on<HomePageChangedEvent>(onPageChanged);
    on<HomeAnimateToPageEvent>(animateToPage);
  }

  onPageChanged(HomePageChangedEvent event, Emitter<HomeState> emit) {
    currentTap = event.index;
    emit(HomePageChangedState(currentTap));
  }

  animateToPage(HomeAnimateToPageEvent event, Emitter<HomeState> emit){
    currentTap = event.index;
    pageController!.animateToPage(
      event.index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }
}