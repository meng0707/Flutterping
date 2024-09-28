import 'package:flutter/material.dart';

class SignupStyles {
  // กำหนดสีของปุ่ม
  static const Color primaryButtonColor = Colors.blueAccent;

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

  // สไตล์ข้อความหัวเรื่อง
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // สไตล์สำหรับการระบุข้อมูล
  static const InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    labelStyle: TextStyle(color: Colors.grey),
  );
}
