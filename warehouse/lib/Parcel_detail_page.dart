import 'package:flutter/material.dart';

class ParcelDetailPage extends StatelessWidget {
  final String itemName;
  final String category;
  final int quantity;

  ParcelDetailPage({
    required this.itemName,
    required this.category,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดพัสดุ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ชื่อพัสดุ: $itemName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'หมวดหมู่: $category',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'จำนวน: $quantity',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
