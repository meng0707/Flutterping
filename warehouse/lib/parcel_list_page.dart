import 'package:flutter/material.dart';
import 'package:warehouse/services/api_service.dart'; // นำเข้า ApiService ที่ใช้เชื่อมต่อ API

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการพัสดุ'),
        backgroundColor: Colors.blueAccent,
      ),
      body: parcels.isEmpty
          ? Center(
              child: Text('ไม่พบข้อมูลพัสดุ')) // แสดงข้อความเมื่อไม่พบข้อมูล
          : ListView.builder(
              itemCount: parcels.length,
              itemBuilder: (context, index) {
                final parcel = parcels[index];
                return ListTile(
                  title: Text('ชื่อพัสดุ: ${parcel['item']}'),
                  subtitle: Text(
                      'หมวดหมู่: ${parcel['category']} - จำนวน: ${parcel['quantity']}'),
                );
              },
            ),
    );
  }
}
