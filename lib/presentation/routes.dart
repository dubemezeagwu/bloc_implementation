import 'package:bloc_implementation/bloc/counter_cubit.dart';
import 'package:bloc_implementation/bloc/internet_cubit.dart';
import 'package:bloc_implementation/presentation/home_page.dart';
import 'package:bloc_implementation/presentation/second_page.dart';
import 'package:bloc_implementation/presentation/third_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Map<String, Widget Function(BuildContext)> routes = {
//   "/": (context) =>
//       BlocProvider.value(
//         value: counterCubit,
//         child: const HomePage(title: "Home Screen", color: Colors.yellow),
//       ),
//   "/second": (context) =>
//       BlocProvider.value(
//         value: counterCubit,
//         child: const SecondPage(title: "Second Screen", color: Colors.red),
//       ),
//   "/third": (context) =>
//       BlocProvider.value(
//         value: counterCubit,
//         child: const ThirdPage(title: "Home Screen", color: Colors.brown),
//       ),
// };


class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();


  Route? onGenerateRoute (RouteSettings routeSettings){
    switch (routeSettings.name){
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _counterCubit,
              child: HomePage(
                  title: "Home Screen",
                  color: Colors.yellow),
            ));
        break;
      case '/second':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _counterCubit,
              child: SecondPage(
                  title: "Second Screen",
                  color: Colors.red),
            ));
        break;
      case '/third':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _counterCubit,
              child: ThirdPage(
                  title: "Third Screen",
                  color: Colors.brown),
            ));
        break;
      default:
        return null;
    }
  }

  void dispose (){
    _counterCubit.close();
  }
}