import 'package:flutter/material.dart';

class WarehousePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warehouse Page'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to the Warehouse!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // เพิ่มรายละเอียดอื่น ๆ ที่คุณต้องการแสดงในหน้าคลังสินค้า
            ],
          ),
        ),
      ),
    );
  }
}
