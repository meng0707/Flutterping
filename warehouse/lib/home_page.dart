import 'package:flutter/material.dart';
import 'add_page.dart';
import 'Withdraw_page.dart';
import 'Parcellist_page.dart';
import 'login_page.dart'; // นำเข้า LoginPage
import 'styles/home.dart'; // นำเข้า styles.dart

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page', style: AppStyles.appBarTheme.titleTextStyle),
        backgroundColor: AppStyles.primaryButtonColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHomeButton(
                context,
                'เพิ่มพัสดุ',
                Icons.add_box,
                AppStyles.primaryButtonColor,
                WarehousePage(),
              ),
              SizedBox(height: 20),
              _buildHomeButton(
                context,
                'เบิกพัสดุ',
                Icons.assignment,
                AppStyles.secondaryButtonColor,
                RequisitionPage(),
              ),
              SizedBox(height: 20),
              _buildHomeButton(
                context,
                'แสดงรายการพัสดุ',
                Icons.list,
                AppStyles.primaryButtonColor,
                ParcelListPage(),
              ),
              SizedBox(height: 20), // เพิ่มระยะห่างสำหรับปุ่ม Logout
              ElevatedButton(
                onPressed: () {
                  _logout(context); // เรียกใช้ฟังก์ชัน Logout
                },
                child: Text(
                  'Logout',
                  style: AppStyles.buttonTextStyle,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppStyles.secondaryButtonColor, // ปรับสีปุ่มตามต้องการ
                  padding: AppStyles.buttonPadding,
                  shape: AppStyles.buttonShape,
                ),
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
        style: AppStyles.buttonTextStyle,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: AppStyles.buttonPadding,
        shape: AppStyles.buttonShape,
      ),
    );
  }

  void _logout(BuildContext context) {
    // คุณสามารถเพิ่มโค้ดสำหรับการ Logout ที่นี่ เช่น การลบ token หรือข้อมูลการเข้าสู่ระบบ
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPage()), // นำไปยังหน้า LoginPage
    );
  }
}
