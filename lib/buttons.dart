import 'package:flutter/material.dart';

class myButtons extends StatelessWidget {
  final color;
  final String buttontext;
  final textColor;
  final buttonTapped;

  myButtons(
      {super.key,
      required this.color,
      required this.buttontext,
      this.textColor, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: buttonTapped,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttontext,
                style: TextStyle(
                  fontSize: 20,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
