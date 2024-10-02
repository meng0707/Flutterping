import 'package:flutter/material.dart';
import 'Signup_page.dart'; // นำเข้าหน้า SignupPage
import 'Login_page.dart'; // นำเข้าหน้า LoginPage
import 'styles/maincss.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warehouse App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppStyles.primaryColor, // ใช้สีพื้นฐาน
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', // ใช้เส้นทางเริ่มต้นเป็น '/'
      routes: {
        '/': (context) => MyHomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => MyHomePage());
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Warehouse App'),
        backgroundColor: AppStyles.primaryColor, // ใช้สีจาก styles.dart
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            // ทำให้สามารถเลื่อนดูได้
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Icon with shadow effect
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppStyles.primaryColor,
                    child: Icon(
                      Icons.warehouse,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'ยินดีต้อนรับสู่ระบบคลังสินค้า',
                  style: AppStyles.headerTextStyle.copyWith(
                    fontSize: 24, // เพิ่มขนาดฟอนต์
                    color: AppStyles.primaryColor, // ใช้สีจาก styles.dart
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Please choose:',
                  style: AppStyles.subtitleTextStyle.copyWith(
                    fontSize: 18, // เพิ่มขนาดฟอนต์
                    color: AppStyles.secondaryColor, // ใช้สีจาก styles.dart
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                // ปรับปรุงปุ่มให้มีมุมโค้งมน
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('สมัครสมาชิก'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles
                        .secondaryColor, // เปลี่ยนสีปุ่มจาก styles.dart
                    padding:
                        AppStyles.buttonPadding, // ใช้ padding จาก styles.dart
                    textStyle: AppStyles.buttonTextStyle.copyWith(
                      color: Colors.black, // กำหนดสีข้อความให้เป็นสีดำ
                    ),
                    shape:
                        AppStyles.buttonShape, // ใช้รูปร่างปุ่มจาก styles.dart
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('เข้าสู่ระบบ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 75, 174, 255), // เปลี่ยนสีปุ่มจาก styles.dart
                    padding:
                        AppStyles.buttonPadding, // ใช้ padding จาก styles.dart
                    textStyle: AppStyles.buttonTextStyle.copyWith(
                      color: Colors.white, // เปลี่ยนสีข้อความให้เป็นสีขาว
                    ),
                    shape:
                        AppStyles.buttonShape, // ใช้รูปร่างปุ่มจาก styles.dart
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
