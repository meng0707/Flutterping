import 'package:flutter/material.dart';
import 'warehouse_page.dart'; // นำเข้าหน้า WarehousePage
import 'requisition_page.dart'; // นำเข้าหน้า RequisitionPage
import 'parcel_list_page.dart'; // นำเข้าหน้า ParcelListPage

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WarehousePage()),
                );
              },
              child: Text('เพิ่มพัสดุ'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequisitionPage()),
                );
              },
              child: Text('เบิกพัสดุ'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParcelListPage()),
                );
              },
              child: Text('แสดงรายการพัสดุ'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
