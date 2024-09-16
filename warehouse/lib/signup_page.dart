import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart';

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
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _signup,
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
