import 'package:flutter/material.dart';

class AppStyles {
  // กำหนดสีของปุ่ม
  static const Color primaryButtonColor = Colors.blueAccent; // สีปุ่มหลัก
  static const Color secondaryButtonColor = Colors.greenAccent; // สีปุ่มรอง
  static const Color buttonBorderColor = Colors.grey; // สีขอบปุ่ม

  // กำหนดสไตล์ข้อความในปุ่ม
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    color: Color.fromARGB(255, 248, 248, 248), // สีข้อความในปุ่ม
    fontWeight: FontWeight.bold, // ทำให้ข้อความตัวหนา
  );

  // กำหนด padding ของปุ่ม
  static const EdgeInsets buttonPadding =
      EdgeInsets.symmetric(horizontal: 30, vertical: 15); // Padding ของปุ่ม

  // กำหนดรูปร่างของปุ่ม
  static RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10), // รัศมีของมุมปุ่ม
    side: BorderSide(color: buttonBorderColor, width: 1), // ขอบของปุ่ม
  );

  // กำหนดสไตล์ AppBar
  static AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: primaryButtonColor,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

  // กำหนดสไตล์สำหรับข้อความในหน้า
  static const TextStyle pageTitleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black, // สีข้อความหลัก
  );

  // กำหนดสไตล์ของ Card
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 5,
        offset: Offset(0, 3), // ตำแหน่งของเงา
      ),
    ],
  );
}
