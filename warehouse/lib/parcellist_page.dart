import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart';
import 'styles/parcellist.dart';
import 'item_edit_page.dart';
import 'parcel_detail_page.dart'; // นำเข้า ParcelDetailPage ที่สร้างขึ้นใหม่

class ParcelListPage extends StatefulWidget {
  @override
  _ParcelListPageState createState() => _ParcelListPageState();
}

class _ParcelListPageState extends State<ParcelListPage> {
  List<dynamic> parcels = [];

  @override
  void initState() {
    super.initState();
    _fetchParcels();
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
        _fetchParcels();
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
      body: parcels.isEmpty
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
                      // เมื่อกดที่ ListTile จะแสดงหน้ารายละเอียดพัสดุ
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParcelDetailPage(
                            itemName: parcel['item'],
                            category: parcel['category'],
                            quantity: parcel['quantity'],
                          ),
                        ),
                      );
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
                            );
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
    );
  }
}
