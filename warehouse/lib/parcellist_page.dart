import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart'; // นำเข้า ApiService ที่ใช้เชื่อมต่อ API
import 'styles/parcellist.dart'; // นำเข้าไฟล์สำหรับการตกแต่ง
import 'item_edit_page.dart'; // นำเข้า ItemEditPage

class ParcelListPage extends StatefulWidget {
  @override
  _ParcelListPageState createState() => _ParcelListPageState();
}

class _ParcelListPageState extends State<ParcelListPage> {
  List<dynamic> parcels = []; // เก็บข้อมูลพัสดุที่ดึงมา

  @override
  void initState() {
    super.initState();
    _fetchParcels(); // ดึงข้อมูลเมื่อหน้าโหลด
  }

  Future<void> _fetchParcels() async {
    try {
      // ดึงข้อมูลพัสดุจาก API
      List<dynamic> fetchedParcels = await ApiService.fetchParcels();
      print('Fetched parcels: $fetchedParcels'); // Debug ตรงนี้
      setState(() {
        parcels = fetchedParcels; // ตั้งค่าข้อมูลที่ดึงมา
      });
    } catch (e) {
      print('Error fetching parcels: $e');
    }
  }

  Future<void> _deleteParcel(String itemId) async {
    try {
      final response =
          await ApiService.deleteParcel(itemId); // เรียกใช้ฟังก์ชันลบพัสดุ
      if (response != null && response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ลบพัสดุเรียบร้อยแล้ว')),
        );
        // อัปเดตรายการหลังจากลบ
        _fetchParcels();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่สามารถลบพัสดุได้')),
        );
      }
    } catch (e) {
      print('Error deleting parcel: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายการพัสดุ',
          style:
              ParcelListStyles.appBarTextStyle, // ใช้สไตล์จาก parcellist.dart
        ),
        backgroundColor:
            ParcelListStyles.appBarColor, // ใช้สีจาก parcellist.dart
      ),
      body: parcels.isEmpty
          ? Center(
              child: Text(
                'ไม่พบข้อมูลพัสดุ',
                style: ParcelListStyles
                    .emptyTextStyle, // ใช้สไตล์จาก parcellist.dart
              ),
            ) // แสดงข้อความเมื่อไม่พบข้อมูล
          : ListView.builder(
              itemCount: parcels.length,
              itemBuilder: (context, index) {
                final parcel = parcels[index];
                return Card(
                  margin: ParcelListStyles
                      .cardMargin, // ใช้ระยะห่างจาก parcellist.dart
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(
                      'ชื่อพัสดุ: ${parcel['item']}',
                      style: ParcelListStyles
                          .titleTextStyle, // ใช้สไตล์จาก parcellist.dart
                    ),
                    subtitle: Text(
                      'หมวดหมู่: ${parcel['category']} - จำนวน: ${parcel['quantity']}',
                      style: ParcelListStyles
                          .subtitleTextStyle, // ใช้สไตล์จาก parcellist.dart
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // นำทางไปยังหน้าแก้ไขเมื่อกดปุ่มแก้ไข
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemEditPage(
                                  itemId: parcel['_id'], // รหัสพัสดุ
                                  itemName: parcel['item'],
                                  category: parcel['category'],
                                  quantity: parcel['quantity'],
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // ยืนยันการลบก่อนทำการลบ
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ยืนยันการลบ'),
                                  content:
                                      Text('คุณแน่ใจหรือไม่ว่าจะลบพัสดุนี้?'),
                                  actions: [
                                    TextButton(
                                      child: Text('ยกเลิก'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // ปิดกล่องยืนยัน
                                      },
                                    ),
                                    TextButton(
                                      child: Text('ยืนยัน'),
                                      onPressed: () {
                                        _deleteParcel(parcel['_id']); // ลบพัสดุ
                                        Navigator.of(context)
                                            .pop(); // ปิดกล่องยืนยัน
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
