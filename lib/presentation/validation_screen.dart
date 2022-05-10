import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/validation_provider.dart';
class ValidationScreen extends StatefulWidget {
  const ValidationScreen({Key? key}) : super(key: key);

  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValidationScreenProvider>(
      create: (context) => ValidationScreenProvider(),
      child: Builder(
          builder: (context) {
            return Scaffold(
              body: Container(
                padding: const EdgeInsets.all(16),
                child: Form(
                    child: Consumer<ValidationScreenProvider>(
                      builder: (BuildContext context, provider, Widget? child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (provider.isEligible == null) ? Colors.orangeAccent : (provider.isEligible!) ? Colors.green : Colors.redAccent
                              ),
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(height: 16,),
                            TextFormField(
                              controller: ageController,
                              decoration: const InputDecoration(
                                hintText: "Give your age",

                              ),
                            ),
                            const SizedBox(height: 16,),
                            Container(
                              width: double.infinity,
                              child: FlatButton(
                                child: const Text("Check"),
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () {
                                  final int age = int.parse(ageController.text.trim());
                                  provider.checkEligibility(age);
                                },
                              ),
                            ),
                            const SizedBox(height: 16,),

                            Text(provider.eligibilityMessage)
                          ],
                        );
                      },)
                ),
              ),
            );
          }
      ),
    );
  }
}