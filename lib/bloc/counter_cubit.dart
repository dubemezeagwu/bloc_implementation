import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_implementation/bloc/internet_cubit.dart';
import 'package:bloc_implementation/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';


class CounterCubit extends Cubit<CounterState> with HydratedMixin {
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

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);

  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return state.toMap();
  }

  // @override
  // Future<void> close() {
  //   // TODO: implement close
  //   internetStreamSubscription?.cancel();
  //   return super.close();
  // }
}

