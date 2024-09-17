import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart'; // นำเข้า ApiService

class RequisitionPositivePage extends StatefulWidget {
  @override
  _RequisitionPositivePageState createState() =>
      _RequisitionPositivePageState();
}

class _RequisitionPositivePageState extends State<RequisitionPositivePage> {
  String? selectedCategory;
  String? selectedItem;
  final TextEditingController _quantityController =
      TextEditingController(); // เพิ่มตัวควบคุมสำหรับช่องจำนวน

  Map<String, List<String>> categories = {
    'ไฟฟ้า': [
      'สายไฟ',
      'สวิตช์',
      'เบรกเกอร์',
      'ท่อหุ้มสายไฟ',
      'หลอดไฟ',
      'เทปพันสายไฟ'
    ],
    'ประปา': [
      'ท่อ PVC/PE',
      'ข้อต่อท่อ',
      'วาล์ว',
      'ปะเก็น',
      'เทปพันเกลียว',
      'ท่อเหล็ก',
      'ท่อทองแดง',
      'ปั๊มน้ำ',
      'ฟิลเตอร์'
    ],
    'อาคาร': [
      'สีทาบ้าน',
      'ปูนซีเมนต์',
      'กระเบื้อง',
      'กาวติดกระเบื้อง',
      'ปะเก็น',
      'สกรู',
      'ไม้เทียมน',
      'น้ำยาทำความสะอาด'
    ]
  };

  void _addParcel() async {
    if (selectedCategory != null &&
        selectedItem != null &&
        _quantityController.text.isNotEmpty) {
      final int quantity = int.parse(_quantityController.text);
      final response = await ApiService.addParcel(
          selectedCategory!, selectedItem!, quantity);

      if (response != null && response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เพิ่มพัสดุสำเร็จ')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาดในการเพิ่มพัสดุ')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณาเลือกประเภทพัสดุและใส่จำนวนให้ครบถ้วน')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มพัสดุ'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'เลือกประเภทพัสดุ',
              style: TextStyle(fontSize: 18),
            ),
            DropdownButton<String>(
              hint: Text('เลือกประเภท'),
              value: selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue;
                  selectedItem =
                      null; // รีเซ็ตตัวเลือกพัสดุเมื่อเปลี่ยนหมวดหมู่
                });
              },
              items: categories.keys.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            if (selectedCategory != null) ...[
              SizedBox(height: 20),
              Text(
                'เลือกพัสดุ',
                style: TextStyle(fontSize: 18),
              ),
              DropdownButton<String>(
                hint: Text('เลือกพัสดุ'),
                value: selectedItem,
                onChanged: (newValue) {
                  setState(() {
                    selectedItem = newValue;
                  });
                },
                items: categories[selectedCategory]!.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ),
            ],
            if (selectedItem != null) ...[
              SizedBox(height: 20),
              Text(
                'ใส่จำนวนพัสดุ',
                style: TextStyle(fontSize: 18),
              ),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(
                  hintText: 'กรอกจำนวน',
                ),
                keyboardType:
                    TextInputType.number, // ตั้งให้รองรับการป้อนตัวเลข
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addParcel,
              child: Text('เพิ่มพัสดุ'),
            ),
          ],
        ),
      ),
    );
  }
}
