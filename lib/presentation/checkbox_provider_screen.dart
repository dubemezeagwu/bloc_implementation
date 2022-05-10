import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/drinks_provider.dart';
import 'my_checkbox_app.dart';

class CheckboxProviderScreen extends StatefulWidget {
  const CheckboxProviderScreen({Key? key,}) : super(key: key);


  @override
  State<CheckboxProviderScreen> createState() => _CheckboxProviderScreenState();
}

class _CheckboxProviderScreenState extends State<CheckboxProviderScreen> {
  // List of drinks, of type Drink, which we want to display along side the checkboxes.
  // We already set the the selected boolean for the checkboxes initially to be false.
  List<Drink> drinks= [

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PROVIDER"),
      ),
      body: Container(
        child: Consumer<DrinksProvider>(
          builder: (context, drinksProvider, child) => Column(
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
              ...drinksProvider.drinks
                  .map((drink) => DrinksWidget(
                drink: drink,
                onChanged: (value) {
                  drinksProvider.selectDrink(drink, value!);
                },),
              ).toList(),
              Text("The order is"),
              Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                      title: Text(drinksProvider.selectedDrinks[index].drinkName),),
                    itemCount: drinksProvider.selectedDrinks.length,))
            ],
          ),
        ),
      ),
    );
  }
}