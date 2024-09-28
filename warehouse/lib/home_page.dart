import 'package:flutter/material.dart';
import 'add_page.dart';
import 'Withdraw_page.dart';
import 'parcellist_page.dart';
import 'styles/home.dart'; // นำเข้า styles.dart

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        // ใช้ Center เพื่อจัดให้อยู่กึ่งกลาง
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // กึ่งกลางแนวนอน
            children: [
              _buildHomeButton(
                context,
                'เพิ่มพัสดุ',
                Icons.add_box,
                const Color.fromARGB(255, 46, 108, 216),
                WarehousePage(),
              ),
              SizedBox(height: 20),
              _buildHomeButton(
                context,
                'เบิกพัสดุ',
                Icons.assignment,
                const Color.fromARGB(255, 49, 39, 190),
                RequisitionPage(),
              ),
              SizedBox(height: 20),
              _buildHomeButton(
                context,
                'แสดงรายการพัสดุ',
                Icons.list,
                const Color.fromARGB(255, 60, 70, 214),
                ParcelListPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context, String title, IconData icon,
      Color color, Widget page) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      icon: Icon(icon, size: 30, color: Colors.white),
      label: Text(
        title,
        style: AppStyles.buttonTextStyle, // ใช้สไตล์จาก styles.dart
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: AppStyles.buttonPadding, // ใช้ padding จาก styles.dart
        shape: AppStyles.buttonShape, // ใช้รูปร่างปุ่มจาก styles.dart
      ),
    );
  }
}
