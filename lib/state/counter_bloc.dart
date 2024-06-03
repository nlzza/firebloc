import 'package:flutter_bloc/flutter_bloc.dart';

sealed class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterDecrementEvent extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementEvent>(
      (_, emit) => emit(state + 1),
    );

    on<CounterDecrementEvent>(
      (_, emit) => emit(state - 1),
    );
  }
}
