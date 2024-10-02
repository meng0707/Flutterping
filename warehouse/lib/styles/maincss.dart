import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color buttonColorSignup =
      Color(0xFFE0E0E0); // สีสำหรับปุ่มสมัครสมาชิก
  static const Color buttonColorLogin =
      Color(0xFF2196F3); // สีสำหรับปุ่มเข้าสู่ระบบ
  static const Color textColor = Color(0xFF000000); // สีข้อความหลัก

  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 18,
    color: textColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 20,
    color: Color.fromARGB(255, 228, 228, 228),
  );

  static const EdgeInsets buttonPadding =
      EdgeInsets.symmetric(vertical: 12, horizontal: 16);
  static const RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );
}
