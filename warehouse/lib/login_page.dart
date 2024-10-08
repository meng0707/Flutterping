import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart';
import 'home_page.dart'; // นำเข้าหน้า HomePage
import 'Signup_page.dart'; // นำเข้าหน้า SignupPage
import 'styles/login.dart'; // นำเข้า login_styles.dart สำหรับตกแต่ง

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final response = await ApiService.login(username, password, context);

    if (response != null && response.statusCode == 200) {
      // นำผู้ใช้ไปยังหน้า HomePage หลังจากล็อกอินสำเร็จ
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // แสดงข้อความผิดพลาดถ้าการล็อกอินไม่สำเร็จ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณากรอกชื่อผู้ใช้และรหัสผ่านให้ครบถ้วน.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application login'),
        backgroundColor: LoginStyles.primaryButtonColor, // ใช้สีจาก LoginStyles
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            // เพิ่ม SingleChildScrollView
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.warehouse,
                  size: 100,
                  color: LoginStyles.primaryButtonColor, // ใช้สีจาก LoginStyles
                ),
                SizedBox(height: 20),
                Text(
                  'Login to application',
                  style: LoginStyles
                      .headerTextStyle, // ใช้สไตล์ข้อความจาก LoginStyles
                  textAlign: TextAlign.center, // จัดกลางข้อความ
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _usernameController,
                  decoration: LoginStyles.inputDecoration.copyWith(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: LoginStyles.inputDecoration.copyWith(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login',
                      style: LoginStyles.buttonTextStyle), // เพิ่มสไตล์ข้อความ
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LoginStyles
                        .primaryButtonColor, // ใช้สีปุ่มจาก LoginStyles
                    padding: LoginStyles
                        .buttonPadding, // ใช้ padding จาก LoginStyles
                    shape: LoginStyles
                        .buttonShape, // ใช้รูปร่างปุ่มจาก LoginStyles
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // นำผู้ใช้ไปยังหน้า SignupPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    'หากยังไม่มีบัญชี กดสมัครตรงนี้เลย!!',
                    style: TextStyle(
                        color: LoginStyles.primaryButtonColor), // ใช้สีปุ่ม
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
