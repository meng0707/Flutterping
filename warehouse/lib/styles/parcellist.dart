import 'package:flutter/material.dart';

class ParcelListStyles {
  // พาเลตสี
  static const Color appBarColor = Colors.blueAccent;
  static const Color titleColor = Colors.black;
  static const Color subtitleColor = Colors.grey;

  // สไตล์ข้อความ
  static const TextStyle appBarTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: titleColor,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 16,
    color: subtitleColor,
  );

  static const TextStyle emptyTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.redAccent,
    fontWeight: FontWeight.bold,
  );

  // Card ระยะห่างและสไตล์
  static const EdgeInsets cardMargin = EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 16.0,
  );
}
