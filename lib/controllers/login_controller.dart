import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<bool> login(String username, String password) async {
    final url = Uri.parse('https://dummyjson.com/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'expiresInMins': 30, // optional
        }),
      );
      if (response.statusCode == 200) {
        // If the login is successful, return true
        print(jsonDecode(response.body));
        return true;
      } else {
        // Handle failure
        print('Login failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
