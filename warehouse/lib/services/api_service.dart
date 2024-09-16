import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl =
      'http://localhost:3000'; // แก้ไข URL ตามเซิร์ฟเวอร์ของคุณ

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
      final response = await http.get(Uri.parse('$baseUrl/users'));

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
      return response;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
