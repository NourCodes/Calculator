import 'package:calc/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = "";
  var userAnswer = "";
  final myTextStyle =
      TextStyle(fontSize: 30, color: Colors.deepPurple.shade900);
  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "×",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=", //last one so if the list is 20 /20-1 will be = button
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Column(
        children: [
          Expanded(
            child: Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                //clear button
                if (index == 0 && userQuestion != null) {
                  return myButtons(
                    color: Colors.green,
                    buttonTapped: () {
                      setState(() {

                        userQuestion = "";
                        userAnswer ="";
                      });
                    },
                    buttontext: buttons[index],
                    textColor: Colors.white,
                  );
                  //Delete Button
                } else if (index == 1) {
                  return myButtons(
                    buttonTapped: () {
                      setState(() {
                        userQuestion =
                            userQuestion.substring(0, userQuestion.length - 1);
                      });
                    },
                    color: Colors.red,
                    buttontext: buttons[index],
                    textColor: Colors.white,
                  );
                }
                //equal button
                else if (index == buttons.length - 1) {
                  return myButtons(
                    buttonTapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    color: Colors.deepPurple,
                    buttontext: buttons[index],
                    textColor: Colors.white,
                  );
                }

                //rst of the buttons

                else {
                  return myButtons(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                    color: isOperator(buttons[index])
                        ? Colors.deepPurple
                        : Colors.deepPurple.shade50,
                    buttontext: buttons[index],
                    textColor: isOperator(buttons[index])
                        ? Colors.white
                        : Colors.deepPurple,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "%" || x == "/" || x == "-" || x == "+" || x == "=" || x == "×") {
      return true;
    } else {
      return false;
    }
  }

  void equalPressed() {//used a package
    // the multiplication sign doesnt not work in this package we need to replace it by *
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll("×", "*");
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
