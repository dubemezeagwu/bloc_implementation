import 'package:bloc_implementation/bloc/counter_cubit.dart';
import 'package:bloc_implementation/bloc/internet_cubit.dart';
import 'package:bloc_implementation/bloc/settings_cubit.dart';
import 'package:bloc_implementation/presentation/home_page.dart';
import 'package:bloc_implementation/presentation/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Calls the native code to initializes the storage and link it HydratedBloc.
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory()
  );


  HydratedBlocOverrides.runZoned(
          () => runApp(MyApp(
            appRouter: AppRouter(),
            connectivity: Connectivity(),
          )),
    storage: storage
  );
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext appContext) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (internetCubitContext) => InternetCubit(connectivity: widget.connectivity)
        ),
        BlocProvider(
            create: (counterCubitContext) => CounterCubit()
        ),
        BlocProvider(
            create: (settingsCubitContext) => SettingsCubit(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        onGenerateRoute: widget.appRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}




// void main() async {
//   Stream<int> stream = boatStream();
//
//   stream.listen((recieved){
//     print("Recieved boat no: " + recieved.toString());
//   });
// }
//
//
// Stream<int> boatStream () async* {
//   for (int i = 1; i <= 10; i++){
//     print("SENT Boat number: " + i.toString());
//     await Future.delayed(Duration(seconds: 2));
//     yield i;
//   }
// }

