import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart'; // นำเข้า ApiService
import 'styles/Withdraw.dart'; // นำเข้าหน้าสไตล์

class RequisitionPage extends StatefulWidget {
  @override
  _RequisitionPageState createState() => _RequisitionPageState();
}

class _RequisitionPageState extends State<RequisitionPage> {
  String? selectedCategory;
  String? selectedItem;
  final TextEditingController _quantityController = TextEditingController();

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

  void _requisitionParcel() async {
    if (selectedCategory != null &&
        selectedItem != null &&
        _quantityController.text.isNotEmpty) {
      final int quantity = int.parse(_quantityController.text);
      final response = await ApiService.requisitionParcel(
          selectedCategory!, selectedItem!, quantity);

      if (response != null && response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เบิกพัสดุสำเร็จ')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาดในการเบิกพัสดุ')),
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
        title: Text(
          'Receive the parcel',
          style: WithdrawStyles.appBarTextStyle, // ใช้สไตล์ที่สร้างไว้
        ),
        backgroundColor:
            WithdrawStyles.appBarColor, // ใช้สีของ AppBar จากสไตล์ที่สร้างไว้
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เลือกประเภทพัสดุ',
                          style: WithdrawStyles.headerTextStyle,
                        ),
                        DropdownButton<String>(
                          hint: Text('เลือกประเภท'),
                          value: selectedCategory,
                          onChanged: (newValue) {
                            setState(() {
                              selectedCategory = newValue;
                              selectedItem = null;
                            });
                          },
                          items: categories.keys.map((category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                if (selectedCategory != null) ...[
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'เลือกพัสดุ',
                            style: WithdrawStyles.headerTextStyle,
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
                      ),
                    ),
                  ),
                ],
                if (selectedItem != null) ...[
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ใส่จำนวนพัสดุ',
                            style: WithdrawStyles.headerTextStyle,
                          ),
                          TextField(
                            controller: _quantityController,
                            decoration: InputDecoration(
                              hintText: 'กรอกจำนวน',
                              border: WithdrawStyles.textFieldBorder,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _requisitionParcel,
                  child: Text('เบิกพัสดุ'),
                  style: WithdrawStyles.elevatedButtonStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
