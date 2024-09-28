import 'package:flutter/material.dart';

class WithdrawStyles {
  static const Color appBarColor = Colors.blueAccent;
  static const Color buttonColor = Color.fromARGB(255, 110, 156, 255);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black;
  static const Color secondaryTextColor = Colors.grey;

  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: Colors.grey, width: 1),
  );

  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: buttonColor,
    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
    textStyle: TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
