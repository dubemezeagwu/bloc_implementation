import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/drinks_provider.dart';
import 'checkbox_provider_screen.dart';

class MyCheckboxApp extends StatelessWidget {
  const MyCheckboxApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => DrinksProvider(),
        child: CheckboxProviderScreen(),
      ),
    );
  }
}

class MyCheckboxHomePage extends StatefulWidget {
  const MyCheckboxHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyCheckboxHomePage> createState() => _MyCheckboxHomePageState();
}

class _MyCheckboxHomePageState extends State<MyCheckboxHomePage> {
  // List of drinks, of type Drink, which we want to display along side the checkboxes.
  // We already set the the selected boolean for the checkboxes initially to be false.
  List<Drink> drinks= [
    Drink(drinkName: "Water", selected: false),
    Drink(drinkName: "Coffee", selected: false),
    Drink(drinkName: "Red Label", selected: false),
    Drink(drinkName: "Smoothie", selected: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "CheckBox",
            ),
            SizedBox(),
            /* Here we spread the drinks list and map each drink item into the DrinkWidget
            * the drink widget takes in two parameters, each drink being passed and setting
            * it into the drink parameter, it takes an onChanged method which takes a callback
            * as an argument and sets the state by rebuilding the UI anytime the value is
            * changed.
            */
            ...drinks
                .map((drink) => DrinksWidget(
              drink: drink,
              onChanged: (value) {
                setState(() {
                  drink.selected = value!;
                });
              },),
            ).toList(),
            Text("The order is"),
            Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(drinks.where((drink) => drink.selected).toList()[index].drinkName),),
                  itemCount: drinks.where((drink) => drink.selected).length,))
          ],
        ),
      ),
    );
  }
}

class DrinksWidget extends StatelessWidget {
  final Drink drink;
  final Function(bool?) onChanged;

  DrinksWidget({required this.drink, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: drink.selected,
            onChanged: onChanged
        ),
        Text(drink.drinkName)
      ],
    );
  }
}

class Drink {
  final String drinkName;
  bool selected;

  Drink({required this.drinkName,required this.selected});
}