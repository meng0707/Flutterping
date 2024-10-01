import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart'; // นำเข้า ApiService ที่ใช้เชื่อมต่อ API

class ItemEditPage extends StatefulWidget {
  final String itemId; // รหัสพัสดุที่จะทำการแก้ไข
  final String itemName;
  final String category;
  final int quantity;

  ItemEditPage({
    required this.itemId,
    required this.itemName,
    required this.category,
    required this.quantity,
  });

  @override
  _ItemEditPageState createState() => _ItemEditPageState();
}

class _ItemEditPageState extends State<ItemEditPage> {
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.itemName);
    _categoryController = TextEditingController(text: widget.category);
    _quantityController =
        TextEditingController(text: widget.quantity.toString());
  }

  Future<void> _updateItem() async {
    final String name = _nameController.text;
    final String category = _categoryController.text;
    final int quantity = int.tryParse(_quantityController.text) ?? 0;

    // เรียกใช้ ApiService เพื่ออัปเดตข้อมูลพัสดุ
    final response =
        await ApiService.updateParcel(widget.itemId, name, category, quantity);
    if (response != null && response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('แก้ไขข้อมูลพัสดุเรียบร้อยแล้ว')),
      );
      Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('การแก้ไขข้อมูลล้มเหลว')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('แก้ไขข้อมูลพัสดุ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'ชื่อพัสดุ'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'หมวดหมู่'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'จำนวน'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _updateItem,
              child: Text('อัปเดตข้อมูล'),
            ),
          ],
        ),
      ),
    );
  }
}
