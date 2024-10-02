import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl =
      'http://10.104.16.9:3000'; // แก้ไข URL ตามเซิร์ฟเวอร์ของคุณ

  // เก็บ JWT token ที่ได้รับจากการล็อกอิน
  static String? _jwtToken;
  static String? _refreshToken; // ตัวแปรสำหรับเก็บ refresh token

  // ฟังก์ชันสำหรับตั้งค่า JWT token
  static void setJwtToken(String token) {
    _jwtToken = token;
  }

  // ฟังก์ชันสำหรับตั้งค่า Refresh token
  static void setRefreshToken(String token) {
    _refreshToken = token;
  }

  // ฟังก์ชันสำหรับลงทะเบียน (signup)
  static Future<http.Response?> signup(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      return response;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // ฟังก์ชันสำหรับดึงข้อมูลผู้ใช้
  static Future<List<dynamic>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users'),
        headers: <String, String>{
          'Authorization':
              'Bearer ${_jwtToken ?? ''}', // ใช้ JWT token ใน header
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body) as List<dynamic>;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  // ฟังก์ชันสำหรับเข้าสู่ระบบ
  static Future<http.Response?> login(
      String username, String password, BuildContext context) async {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณากรอกชื่อผู้ใช้และรหัสผ่านให้ครบถ้วน')),
      );
      return null;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['token'] != null) {
          setJwtToken(responseBody['token']);
        }
        if (responseBody['refreshToken'] != null) {
          setRefreshToken(responseBody['refreshToken']);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'เข้าสู่ระบบไม่สำเร็จ โปรดตรวจสอบชื่อผู้ใช้และรหัสผ่าน')),
        );
      }
      return response;
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาดในการเข้าสู่ระบบ')),
      );
      return null;
    }
  }

  // ฟังก์ชันสำหรับเพิ่มพัสดุ
  static Future<http.Response?> addParcel(
      String category, String item, int quantity) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add-parcel'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ${_jwtToken ?? ''}', // ใช้ JWT token ใน header
        },
        body: jsonEncode(<String, dynamic>{
          'category': category,
          'item': item,
          'quantity': quantity,
        }),
      );
      return response;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // ฟังก์ชันสำหรับการเรียกใช้พัสดุ
  static Future<http.Response?> requisitionParcel(
      String category, String item, int quantity) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/requisition-parcel'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ${_jwtToken ?? ''}', // ใช้ JWT token ใน header
        },
        body: jsonEncode(<String, dynamic>{
          'category': category,
          'item': item,
          'quantity': quantity,
        }),
      );
      return response;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // ฟังก์ชันสำหรับอัปเดตพัสดุ
  static Future<http.Response?> updateParcel(
      String id, String item, String category, int quantity) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/update-parcel/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'Bearer ${_jwtToken ?? ''}', // ใช้ JWT token ใน header
        },
        body: jsonEncode(<String, dynamic>{
          'item': item,
          'category': category,
          'quantity': quantity,
        }),
      );

      return response;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // ฟังก์ชันสำหรับดึงพัสดุ
  static Future<List<dynamic>> fetchParcels() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/parcels'),
        headers: <String, String>{
          'Authorization':
              'Bearer ${_jwtToken ?? ''}', // เช็คว่า JWT token ถูกส่งไปหรือไม่
        },
      );

      if (response.statusCode == 200) {
        final parsedData = json.decode(response.body);
        print('Response Data: $parsedData'); // Debug: พิมพ์ข้อมูลที่ได้จาก API
        return parsedData as List<dynamic>;
      } else {
        throw Exception('Failed to load parcels');
      }
    } catch (e) {
      print('Error fetching parcels: $e');
      throw e;
    }
  }

  // ฟังก์ชันสำหรับลบพัสดุ
  static Future<http.Response> deleteParcel(String itemId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/parcel/$itemId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_jwtToken ?? ''}', // ใช้ JWT token ใน header
      },
    );
    return response;
  }

  // ฟังก์ชันสำหรับ refresh token
  static Future<void> refreshToken() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/refresh-token'), // ตรวจสอบว่า endpoint ถูกต้อง
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'refreshToken': _refreshToken ?? '',
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['token'] != null) {
          setJwtToken(responseBody['token']);
        }
      } else {
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      print('Error refreshing token: $e');
    }
  }
}
