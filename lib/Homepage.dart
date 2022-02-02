// main.dart
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // the controller for the text field associated with "height"
  final _heightController = TextEditingController();

  // the controller for the text field associated with "weight"
  final _weightController = TextEditingController();

  // The BMI
  double? _bmi;

  // the message at the beginning
  String _message = 'Please enter your height and weight';
  int? _radioSelected;
  String _radioVal = "";
  void _calculate() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    // Check if the inputs are valid
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _message = "Your height and weight must be positive numbers";
      });
      return;
    }

    setState(() {
      _bmi = weight / (height * height);
      if (_bmi! < 18.5) {
        _message = "You are underweight!! Get some good diet";
      } else if (_bmi! < 25) {
        _message = 'Yay !! You body is fine';
      } else if (_bmi! < 30) {
        _message = 'You are overweight!! Check it out';
      } else {
        _message = 'You are obese !! Get some exercise';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 320,
              child: Card(
                color: Colors.white,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(labelText: 'Height (m)'),
                        controller: _heightController,
                      ),
                      TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Weight (kg)',
                        ),
                        controller: _weightController,
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _radioSelected,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                _radioSelected = value as int;
                                _radioVal = 'Male';
                                print(_radioVal);
                              });
                            },
                          ),
                          const Text("Male"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: _radioSelected,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                _radioSelected = value as int;
                                _radioVal = 'Female';
                                print(_radioVal);
                              });
                            },
                          ),
                          const Text("Female"),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: _calculate,
                        child: Text('Calculate'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.pink),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Text(
                          _bmi == null ? 'No Result' : _bmi!.toStringAsFixed(2),
                          style: TextStyle(fontSize: 50),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text(
                          _message,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        child: Text("Share"),
                        onPressed: () {
                          Share.share("My BMI score is $_bmi");
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.pink),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
