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
    addError(Exception("Couldn't write to storage"), StackTrace.current);
    return state.toMap();
  }

  // Everytime a state is emitted, this function will be called with the
  // change instance passed, containing the currentState and nextState.
  @override
  void onChange(Change<CounterState> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print("$error, $stackTrace");
    super.onError(error, stackTrace);
  }


  // @override
  // Future<void> close() {
  //   // TODO: implement close
  //   internetStreamSubscription?.cancel();
  //   return super.close();
  // }
}

