import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart'; // นำเข้า ApiService ที่ใช้เชื่อมต่อ API
import 'styles/parcellist.dart'; // นำเข้าไฟล์สำหรับการตกแต่ง

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
                  ),
                );
              },
            ),
    );
  }
}
