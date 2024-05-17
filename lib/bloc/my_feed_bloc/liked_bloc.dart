import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class LikedBloc extends Bloc<LikedEvent, LikedState> {
  LikedBloc() : super(const LikedState()) {
    on<LikedEvent>((event, emit) {
      emit(state.clone(changeState: !state.changeState));
    });
  }
}

class LikedEvent{
  final bool changeState;

  const LikedEvent({this.changeState = false});
}

class LikedState extends Equatable {
  final bool changeState;

  const LikedState({this.changeState = false});

  LikedState clone({bool? changeState}) {
    return LikedState(
      changeState: changeState ?? this.changeState,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [changeState];
}