import 'package:flutter/material.dart';
import 'signup_page.dart'; // นำเข้าหน้า SignupPage
import 'login_page.dart'; // นำเข้าหน้า LoginPage
import 'styles/maincss.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warehouse App',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.warehouse,
                size: 100,
                color: AppStyles.primaryColor, // ใช้สีจาก styles.dart
              ),
              SizedBox(height: 20),
              Text(
                'ยินดีต้อนรับสู่ต่างโลกครับ :) ',
                style: AppStyles.headerTextStyle, // ใช้สไตล์จาก styles.dart
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'โปรดเลือกครับบบ:',
                style: AppStyles.subtitleTextStyle, // ใช้สไตล์จาก styles.dart
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('สมัครสมาชิก'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 110, 156, 255), // ใช้สีปุ่มจาก styles.dart
                  padding:
                      AppStyles.buttonPadding, // ใช้ padding จาก styles.dart
                  textStyle: AppStyles
                      .buttonTextStyle, // ใช้สไตล์ข้อความจาก styles.dart
                  shape: AppStyles.buttonShape, // ใช้รูปร่างปุ่มจาก styles.dart
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('เข้าสู่ระบบ'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppStyles.secondaryColor, // ใช้สีปุ่มรองจาก styles.dart
                  padding:
                      AppStyles.buttonPadding, // ใช้ padding จาก styles.dart
                  textStyle: AppStyles
                      .buttonTextStyle, // ใช้สไตล์ข้อความจาก styles.dart
                  shape: AppStyles.buttonShape, // ใช้รูปร่างปุ่มจาก styles.dart
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
