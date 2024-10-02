import 'dart:async'; // เพิ่มสำหรับ Timer
import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart';
import 'styles/parcellist.dart';
import 'item_edit_page.dart';
import 'parcel_detail_page.dart';

class ParcelListPage extends StatefulWidget {
  @override
  _ParcelListPageState createState() => _ParcelListPageState();
}

class _ParcelListPageState extends State<ParcelListPage> {
  List<dynamic> parcels = [];
  Timer? _timer; // Timer สำหรับการรีเฟรชอัตโนมัติ

  @override
  void initState() {
    super.initState();
    _fetchParcels();
    // เริ่มการรีเฟรชข้อมูลทุก 2 วินาที
    _timer = Timer.periodic(Duration(seconds: 2), (Timer t) => _fetchParcels());
  }

  @override
  void dispose() {
    _timer?.cancel(); // ยกเลิก Timer เมื่อออกจากหน้า
    super.dispose();
  }

  Future<void> _fetchParcels() async {
    try {
      List<dynamic> fetchedParcels = await ApiService.fetchParcels();
      print('Fetched parcels: $fetchedParcels');
      setState(() {
        parcels = fetchedParcels;
      });
    } catch (e) {
      print('Error fetching parcels: $e');
    }
  }

  Future<void> _deleteParcel(String itemId) async {
    try {
      final response = await ApiService.deleteParcel(itemId);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ลบพัสดุเรียบร้อยแล้ว')),
        );
        _fetchParcels(); // รีเฟรชรายการพัสดุหลังจากลบ
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่สามารถลบพัสดุได้')),
        );
      }
    } catch (e) {
      print('Error deleting parcel: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการลบพัสดุ')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แสดงรายการพัสดุ',
          style: ParcelListStyles.appBarTextStyle,
        ),
        backgroundColor: ParcelListStyles.appBarColor,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchParcels, // Swipe-to-refresh เพื่อรีเฟรชข้อมูล
        child: parcels.isEmpty
            ? Center(
                child: Text(
                  'ไม่พบข้อมูลพัสดุ',
                  style: ParcelListStyles.emptyTextStyle,
                ),
              )
            : ListView.builder(
                itemCount: parcels.length,
                itemBuilder: (context, index) {
                  final parcel = parcels[index];
                  return Card(
                    margin: ParcelListStyles.cardMargin,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      title: Text(
                        'ชื่อพัสดุ: ${parcel['item']}',
                        style: ParcelListStyles.titleTextStyle,
                      ),
                      subtitle: Text(
                        'หมวดหมู่: ${parcel['category']} - จำนวน: ${parcel['quantity']}',
                        style: ParcelListStyles.subtitleTextStyle,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ParcelDetailPage(
                              itemName: parcel['item'],
                              category: parcel['category'],
                              quantity: parcel['quantity'],
                            ),
                          ),
                        ).then((_) {
                          _fetchParcels(); // รีเฟรชข้อมูลเมื่อกลับมาจากหน้ารายละเอียด
                        });
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemEditPage(
                                    itemId: parcel['_id'],
                                    itemName: parcel['item'],
                                    category: parcel['category'],
                                    quantity: parcel['quantity'],
                                  ),
                                ),
                              ).then((_) {
                                _fetchParcels(); // รีเฟรชข้อมูลหลังแก้ไข
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
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
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('ยืนยัน'),
                                        onPressed: () {
                                          _deleteParcel(parcel['_id']);
                                          Navigator.of(context).pop();
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
      ),
    );
  }
}
