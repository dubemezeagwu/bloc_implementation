import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_implementation/bloc/internet_cubit.dart';
import 'package:bloc_implementation/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';


class CounterCubit extends Cubit<CounterState> {
  // final InternetCubit internetCubit;
  // StreamSubscription? internetStreamSubscription;

  CounterCubit() : super(CounterState(counterValue: 0)){
    // monitorInternetCubit();
  }

  // StreamSubscription<InternetState> monitorInternetCubit() {
  //   return internetCubit.stream.listen(
  //         (internetState) {
  //           if (internetState is InternetConnected && internetState.connectionType == ConnectionType.WiFi){
  //             return increment();
  //           } else if (internetState is InternetConnected && internetState.connectionType == ConnectionType.Mobile){
  //             return decrement();
  //           }
  //         });
  // }

  void increment () => emit(CounterState(counterValue: state.counterValue + 1, wasIncremented: true));
  void decrement () => emit(CounterState(counterValue: state.counterValue - 1, wasIncremented: false));

  // @override
  // Future<void> close() {
  //   // TODO: implement close
  //   internetStreamSubscription?.cancel();
  //   return super.close();
  // }
}

