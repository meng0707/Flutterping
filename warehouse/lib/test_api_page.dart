import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart';
import 'package:warehouse/services/api_service.dart';

class TestApiPage extends StatefulWidget {
  @override
  _TestApiPageState createState() => _TestApiPageState();
}

class _TestApiPageState extends State<TestApiPage> {
  @override
  void initState() {
    super.initState();
    _testApi();
  }

  Future<void> _testApi() async {
    try {
      // ทดสอบการเข้าสู่ระบบ
      final loginResponse =
          await ApiService.login('yourUsername', 'yourPassword');
      if (loginResponse?.statusCode == 200) {
        print('Login successful');

        // ทดสอบการดึงรายการพัสดุ
        final parcels = await ApiService.fetchParcels();
        print('Parcels: $parcels');
      } else {
        print('Login failed');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test API'),
      ),
      body: Center(
        child: Text('Testing API... Check console for output'),
      ),
    );
  }
}
