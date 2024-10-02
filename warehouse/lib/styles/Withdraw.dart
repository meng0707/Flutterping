import 'package:flutter/material.dart';

class WithdrawStyles {
  // พาเลตสี
  static const Color appBarColor = Colors.blueAccent; // สีของ AppBar
  static const Color buttonColor = Colors.white; // เปลี่ยนสีของปุ่มเป็นสีขาว
  static const Color textColor = Colors.black; // สีข้อความหลัก
  static const Color secondaryTextColor = Colors.grey; // สีข้อความรอง

  // สไตล์ข้อความ
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 22, // ขนาดฟอนต์หัวเรื่อง
    fontWeight: FontWeight.bold, // ทำให้ตัวหนา
    color: textColor, // ใช้สีข้อความ
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 18, // ขนาดฟอนต์ย่อย
    fontWeight: FontWeight.w600, // ทำให้ข้อความหนาเล็กน้อย
    color: secondaryTextColor, // ใช้สีข้อความรอง
  );

  static const TextStyle itemTextStyle = TextStyle(
    fontSize: 16, // ขนาดฟอนต์สำหรับรายการ
    color: textColor, // ใช้สีข้อความ
  );

  // Padding และ Margin
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 24.0,
  );

  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 0.0,
  );

  // รูปแบบขอบสำหรับ Text Field
  static const OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)), // รัศมีขอบ
    borderSide: BorderSide(color: Colors.grey, width: 1), // ขอบของ TextField
  );

  // รูปแบบปุ่ม
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: buttonColor, // สีพื้นหลังของปุ่ม
    padding: buttonPadding, // ขนาด padding ของปุ่ม
    textStyle: TextStyle(
      fontSize: 16, // ขนาดฟอนต์ข้อความในปุ่ม
      color: textColor, // เปลี่ยนสีข้อความในปุ่มเป็นสีดำ
      fontWeight: FontWeight.bold, // ทำให้ข้อความในปุ่มตัวหนา
    ),
    shape: null, // เอารัศมีขอบออกจากปุ่ม
  );

  // สไตล์ข้อความใน AppBar
  static const TextStyle appBarTextStyle = TextStyle(
    fontSize: 24, // เพิ่มขนาดฟอนต์ให้ใหญ่ขึ้น
    fontWeight: FontWeight.bold, // ทำให้ฟอนต์หนาขึ้น
    color: Color.fromARGB(
        255, 3, 3, 3), // กำหนดสีของข้อความเป็นสีขาวเพื่อความชัดเจน
  );

  // รูปแบบพื้นหลัง
  static BoxDecoration backgroundDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3), // เงาของพื้นหลัง
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3), // ตำแหน่งของเงา
      ),
    ],
  );
}
