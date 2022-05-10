import 'package:flutter/material.dart';

class ValidationScreenProvider extends ChangeNotifier{
  String _eligibilityMessage = "Given an input";
  bool? _isEligible;

  void checkEligibility(int age){
    if(age >= 18) {
      eligibleForLicense();
    } else {
      notEligibleForLicense();
    }
  }

  void eligibleForLicense(){
    _eligibilityMessage = "You are eligible to apply for Driving License";
    _isEligible = true;

    //Call this whenever there is some change in any field of change notifier.
    notifyListeners();
  }


  void notEligibleForLicense(){
    _eligibilityMessage = "You are not eligible to apply for Driving License";
    _isEligible = false;

    //Call this whenever there is some change in any field of change notifier.
    notifyListeners();
  }

  //Getter for Eligibility message
  String get eligibilityMessage => _eligibilityMessage;

  //Getter for Eligibility flag
  bool? get isEligible => _isEligible;


}