import 'package:flutter/material.dart';

import '../presentation/my_checkbox_app.dart';
class DrinksProvider with ChangeNotifier{
  final List<Drink> _drinks = [
    Drink(drinkName: "Jameson", selected: false),
    Drink(drinkName: "Fanta", selected: false),
    Drink(drinkName: "Hennessy", selected: false),
    Drink(drinkName: "Juice", selected: false),
  ];

  void selectDrink(Drink drink, bool selected){
    _drinks
        .firstWhere((element) => element.drinkName == drink.drinkName)
        .selected = selected;
    notifyListeners();
  }

  // Getter function
  List<Drink> get drinks => _drinks;

  List<Drink> get selectedDrinks => _drinks.where((element) => element.selected).toList();
}