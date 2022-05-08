import 'package:bloc_implementation/bloc/counter_cubit.dart';
import 'package:bloc_implementation/bloc/internet_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';


void main (){
  
  group('Counter Cubit', (){
    late CounterCubit counterCubit;
    setUp((){
      counterCubit = CounterCubit();
    });
    tearDown((){
      counterCubit.close();
    });
    
    test("The initial state of the cubit is equals to the CounterCubit is CounterState(counterValue: 0)", (){
      expect(CounterCubit().state, CounterState(counterValue: 0));
    });

    blocTest(
        "The counter cubit should emit a CounterState(counterValue : 1, wasIncremented: true) "
        "when the cubit.increment() function is called",
        act: (cubit) => counterCubit.increment(),
        expect: () => [CounterState(counterValue: 1,wasIncremented: true)],
        build: () => counterCubit,
    );

    blocTest(
      "The counter cubit should emit a CounterState(counterValue : -1, wasIncremented: false) "
          "when the cubit.decrement() function is called",
      act: (cubit) => counterCubit.decrement(),
      expect: () => [CounterState(counterValue: -1,wasIncremented: false)],
      build: () => counterCubit,
    );
  });
}