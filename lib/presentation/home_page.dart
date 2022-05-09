import 'package:bloc_implementation/bloc/internet_cubit.dart';
import 'package:bloc_implementation/presentation/second_page.dart';
import 'package:bloc_implementation/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_cubit.dart';

class HomePage extends StatefulWidget {
  final Color color;
  const HomePage({
    Key? key,
    required String title,
    required this.color
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext homePageContext) {

    // The listener here reacts to the internetCubit and its state the performs an increment/decrement
    // depending on the type of connection.
    return BlocListener<InternetCubit, InternetState>(
      listener: (internetCubitListenerContext, state) {
        if (state is InternetConnected && state.connectionType == ConnectionType.WiFi){
          // BlocProvider.of<CounterCubit>(context).increment();
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile){
          BlocProvider.of<CounterCubit>(context).decrement();
        }
  },

  child: Scaffold(
    appBar: AppBar(
      title: const Text("Home Screen"),
      actions: [
        IconButton(onPressed: (){
          Navigator.of(context).pushNamed("/settings");
        }, icon: Icon(Icons.settings))
      ],
    ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // This BlocBuilder builds the Text() widget depending on what state is and the type of connection
              // or returns a Circular progress indicator
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (internetCubitBuilderContext, state){
                    if (state is InternetConnected && state.connectionType == ConnectionType.WiFi){
                      return const Text("Connected to Wifi");
                    } else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile){
                      return const Text("Connected to Mobile");
                    } else if (state is InternetDisconnected ) {
                      return const Text("Disconnected");
                    }
                    return const CircularProgressIndicator();
                  }),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (counterCubitListenerContext, state) {
                  if(state.wasIncremented == true){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Incremented"),
                          duration: Duration(seconds: 1),
                        )
                    );
                  }
                  if (state.wasIncremented == false){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Decremented"),
                          duration: Duration(seconds: 1),
                        )
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    height: 300,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: BlocBuilder<CounterCubit, CounterState>(
                            builder: (context, state) {
                              if (state.counterValue < 0) {
                                return Text("Negative: + ${state.counterValue.toString()}");
                              }
                              if (state.counterValue % 2 == 1) {
                                return Text("Odd: + ${state.counterValue.toString()} + ${state.wasIncremented.toString()}");
                              }
                              if (state.counterValue % 2 == 0) {
                                return Text("Even: + ${state.counterValue.toString()}");
                              }
                              return Text("Counter: + ${state.counterValue.toString()}");
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Builder(
                          builder: (context) {
                            final counterState = context.watch<CounterCubit>().state;
                            final internetState =  context.watch<InternetCubit>().state;

                            if(internetState is InternetConnected && internetState.connectionType == ConnectionType.Mobile){
                              return Text("Counter: ${counterState.counterValue.toString()}" "Internet: ${internetState.connectionType.toString()}");
                            } else if (internetState is InternetConnected && internetState.connectionType == ConnectionType.WiFi){
                              return Text("Counter: ${counterState.counterValue.toString()}" "Internet: ${internetState.connectionType.toString()}");
                            } else {
                              return Text("Counter: ${counterState.counterValue.toString()}" "Internet: Disconnected.");
                            }
                          }
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Builder(
                            builder: (context) {
                              final counterValue = context.select((CounterCubit counterCubit) => counterCubit.state.counterValue.toInt());
                              return Text(counterValue.toString());
                            }
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                                child: const Icon(Icons.add),
                                tooltip: "Increment",
                                onPressed: () {
                                  // BlocProvider.of<CounterCubit>(context).increment();
                                  context.read<CounterCubit>().increment();
                                }
                            ),
                            const SizedBox(width: 10,),
                            FloatingActionButton(
                                child: const Icon(Icons.remove),
                                tooltip: "Decrement",
                                onPressed: () {
                                  BlocProvider.of<CounterCubit>(context).decrement();
                                }
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        MaterialButton(
                          color: widget.color,
                          onPressed: (){
                            Navigator.of(context).pushNamed("/second");
                          },
                          child: const Text("Go to Second Screen"),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
);
  }
}