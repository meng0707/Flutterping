import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl =
      'http://10.104.16.9:3000'; // แก้ไข URL ตามเซิร์ฟเวอร์ของคุณ

  // เก็บ JWT token ที่ได้รับจากการล็อกอิน
  static String? _jwtToken;

  // ฟังก์ชันสำหรับตั้งค่า JWT token
  static void setJwtToken(String token) {
    _jwtToken = token;
  }

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
        // หากการตอบสนองของเซิร์ฟเวอร์เป็น 200 OK
        // แปลงข้อมูล JSON เป็น List<dynamic>
        return json.decode(response.body) as List<dynamic>;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
      throw e; // โยนข้อผิดพลาดออกไป
    }
  }

  // ฟังก์ชันสำหรับเข้าสู่ระบบ
  static Future<http.Response?> login(String username, String password) async {
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
      }
      return response;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

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

  static Future<List<dynamic>> fetchParcels() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/parcels'), // ตรวจสอบว่า endpoint ตรงนี้ถูกต้อง
        headers: <String, String>{
          'Authorization':
              'Bearer ${_jwtToken ?? ''}', // เช็คว่า JWT token ถูกส่งไปหรือไม่ (ถ้าจำเป็น)
        },
      );

      if (response.statusCode == 200) {
        // ตรวจสอบการตอบสนองจาก API
        final parsedData = json.decode(response.body);
        print('Response Data: $parsedData'); // Debug: พิมพ์ข้อมูลที่ได้จาก API
        return parsedData as List<dynamic>;
      } else {
        throw Exception('Failed to load parcels');
      }
    } catch (e) {
      print('Error fetching parcels: $e');
      throw e; // โยนข้อผิดพลาดออกไป
    }
  }
}
