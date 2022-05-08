import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/counter_cubit.dart';

class SecondPage extends StatefulWidget {
  final Color color;
  const SecondPage({
    Key? key,
    required String title,
    required this.color
  }) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
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
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: BlocBuilder<CounterCubit, CounterState>(
                    builder: (context, state) {
                      if (state.counterValue < 0) {
                        return Text(
                            "Negative: + ${state.counterValue.toString()}");
                      }
                      if (state.counterValue % 2 == 1) {
                        return Text("Odd: + ${state.counterValue.toString()}");
                      }
                      if (state.counterValue % 2 == 0) {
                        return Text("Even: + ${state.counterValue.toString()}");
                      }
                      return Text("Counter: + ${state.counterValue
                          .toString()}");
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                        child: const Icon(Icons.add),
                        tooltip: "Increment",
                        onPressed: () {
                          BlocProvider.of<CounterCubit>(context).increment();
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
                    Navigator.of(context).pushNamed("/third");
                  },
                  child: const Text("Go to Second Screen"),
                )
              ],
            ),
          ),

        );
      },
    );
  }
}