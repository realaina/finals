import 'package:flutter/material.dart';
import 'package:flutter_application_2/button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: calca(),
    );
  }
}

class calca extends StatefulWidget {
  const calca({super.key});

  @override
  State<calca> createState() => _calcaState();
}

class _calcaState extends State<calca> {
  String number1 = '';
  String operand = '';
  String number2 = '';
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
            bottom: false,
            top: false,
            child: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text('$pastResolution',
                        style: TextStyle(
                            color: Color.fromARGB(6, 247, 5, 94),
                            fontSize: 25)),
                  ),
                )),
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '$number1$operand$number2'.isEmpty
                              ? '0'
                              : '$number1$operand$number2',
                          style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 197, 81, 123)),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Wrap(
                      children: Btn.buttonValues
                          .map((value) => SizedBox(
                              width: value == Btn.n0
                                  ? screenSize.width / 4
                                  : screenSize.width / 4,
                              height: screenSize.height / 10,
                              child: buttonT(value)))
                          .toList(),
                    ))
              ],
            )));
  }

  String pastResolution = '';

/////////////////////////////////////////

  Widget buttonT(value) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: [Btn.delete, Btn.clear, Btn.per].contains(value)
            ? Colors.grey
            : [Btn.add, Btn.divide, Btn.subtract, Btn.multiply].contains(value)
                ? Color.fromARGB(255, 251, 6, 198)
                : Color.fromARGB(255, 241, 234, 234),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0, // Set the aspect ratio to 1.0 for square buttons
          child: Text(
            value,
            style: TextStyle(color: const Color.fromARGB(255, 233, 215, 215), fontSize: 40),
          ),
        ),
      ),
      onPressed: () => {onPressedButton(value)},
    ),
  );
}
  ////############################
  void onPressedButton(String value) {
    if (value == Btn.delete) {
      delete();
      return;
    }

    if (value == Btn.clear) {
      clear();
      return;
    }
    if (value == Btn.per) {
      percentage();
      return;
    }

    if (value == Btn.equals) {
      equality();
      return;
    }
    appending(value);
  }

//calculate

  void equality() {
    if (number1.isEmpty || number2.isEmpty || operand.isEmpty) {
      return;
    } else if (operand.isNotEmpty && number2.isNotEmpty) {
      double num1 = double.parse(number1);
      double num2 = double.parse(number2);
      double result = 0.0;
      switch (operand) {
        case Btn.add:
          result = num1 + num2;
          break;
        case Btn.subtract:
          result = num1 - num2;
          break;
        case Btn.multiply:
          result = num1 * num2;
          break;
        case Btn.divide:
          result = num1 / num2;
          break;
        default:
      }

      pastResolution = '$num1 $operand $num2';
      setState(() {
        if (number1.endsWith('.0')) {
          number1 = number1.substring(0, number1.length - 2);
        }
        number1 = '$result';
        operand = '';
        number2 = '';
      });
    }
  }

//percantage
  void percentage() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      equality();
      return; //jwidwidiwd
    }

    if (operand.isNotEmpty) {
      return;
    }
    final number = double.parse(number1);

    setState(() {
      number1 = '${(number / 100)}';
    });
  }
//clear

  void clear() {
    number1 = '';
    operand = '';
    number2 = '';
    pastResolution = '';
    setState(() {});
  }

  ///claclulation

  ///delete
  void delete() {
    if (number1.isNotEmpty && operand.isEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    } else if (number2.isNotEmpty && operand.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if (number1.isNotEmpty && operand.isNotEmpty && number2.isEmpty) {
      operand = '';
    }
    setState(() {});
  }

//appending
  void appending(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      operand = value;
      if (operand.isNotEmpty && number2.isNotEmpty) {
        equality();
      }
    } else if (number1.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) {
        return;
      }
      if (value == Btn.dot && number1.isEmpty || number1 == Btn.dot) {
        value = '0.';
      }
      number1 += value;
    } else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && number2.contains(Btn.dot)) {
        return;
      }
      if (value == Btn.dot && number2.isEmpty || number2 == Btn.dot) {
        value = '0.';
      }
      number2 += value;
    }
    setState(() {});
  }
}
