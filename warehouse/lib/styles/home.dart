import 'package:flutter/material.dart';

class AppStyles {
  // กำหนดสีของปุ่ม
  static const Color primaryButtonColor = Colors.blueAccent;
  static const Color secondaryButtonColor = Colors.greenAccent;

  // กำหนดสไตล์ข้อความในปุ่ม
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  // กำหนด padding ของปุ่ม
  static const EdgeInsets buttonPadding =
      EdgeInsets.symmetric(horizontal: 30, vertical: 15);

  // กำหนดรูปร่างของปุ่ม
  static RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  );
}
