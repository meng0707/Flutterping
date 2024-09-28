import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart';
import 'styles/signup_styles.dart'; // นำเข้า styles สำหรับหน้าสมัครสมาชิก

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signup() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final response = await ApiService.signup(username, password);
    if (response != null && response.statusCode == 200) {
      // การสมัครสมาชิกสำเร็จ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful!')),
      );
      // ไปยังหน้าอื่น หรือทำการกระทำอื่น ๆ ที่จำเป็น
    } else {
      // การสมัครสมาชิกล้มเหลว
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // เพิ่ม SingleChildScrollView เพื่อป้องกันการตัดข้อมูล
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40), // เพิ่มระยะห่างด้านบน
              Text(
                'สมัครสมาชิก',
                style: SignupStyles.headerTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20), // ระยะห่างระหว่างหัวเรื่องและฟิลด์
              TextField(
                controller: _usernameController,
                decoration: SignupStyles.inputDecoration
                    .copyWith(labelText: 'Username'),
              ),
              SizedBox(height: 20), // เพิ่มระยะห่างระหว่างฟิลด์
              TextField(
                controller: _passwordController,
                decoration: SignupStyles.inputDecoration
                    .copyWith(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20), // เพิ่มระยะห่างระหว่างฟิลด์
              ElevatedButton(
                onPressed: _signup,
                child: Text('สมัครสมาชิก', style: SignupStyles.buttonTextStyle),
                style: ElevatedButton.styleFrom(
                  backgroundColor: SignupStyles.primaryButtonColor,
                  padding: SignupStyles.buttonPadding,
                  shape: SignupStyles.buttonShape,
                ),
              ),
              SizedBox(height: 20), // เพิ่มระยะห่างด้านล่าง
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
                },
                child: Text('กลับไปยังหน้าหลัก'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
