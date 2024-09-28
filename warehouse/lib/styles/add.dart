import 'package:flutter/material.dart';

class WarehouseStyles {
  // พาเลตสี
  static const Color appBarColor = Colors.blueAccent;
  static const Color buttonColor = Color.fromARGB(255, 110, 156, 255);
  static const Color buttonHoverColor = Color.fromARGB(255, 90, 136, 240);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black;
  static const Color secondaryTextColor = Colors.grey;

  // สไตล์ข้อความ
  static const TextStyle headerTextStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: secondaryTextColor,
  );

  static const TextStyle itemTextStyle = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
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

  static const EdgeInsets textFieldPadding = EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 12.0,
  );

  // รูปแบบขอบสำหรับ Text Field
  static const OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: Colors.grey, width: 1),
  );

  // รูปแบบปุ่ม
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    iconColor: buttonColor,
    padding: buttonPadding,
    textStyle: buttonTextStyle,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  static ButtonStyle elevatedButtonHoverStyle = ElevatedButton.styleFrom(
    iconColor: buttonHoverColor,
    padding: buttonPadding,
    textStyle: buttonTextStyle,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );

  // รูปแบบพื้นหลัง
  static BoxDecoration backgroundDecoration = BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3), // เปลี่ยนตำแหน่งของเงา
      ),
    ],
  );
}
