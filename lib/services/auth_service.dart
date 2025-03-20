import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AuthService {
  final String baseUrl = Platform.isAndroid 
    ? "http://10.0.2.2:8000" 
    : "http://localhost:8000";
Future<String> login(String email, String password) async { String url="$baseUrl/login"; // print(url);
    try {
      print(email+"-----"+password);
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"},
      );
      print("hello aaryan");
      print(response);
      if (response.statusCode == 200) {
        return "success";
      } else {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return body["message"] ?? "Login failed. Please try again.";
      }
      // print(response);
    } catch (e) {
      
      return "An error occurred. Please check your internet connection.";
    }
  }

  Future<String> register(String name, String email, String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        body: jsonEncode({"name": name, "email": email, "phone": phone, "password": password}),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 201) {
        return "success";
      } else {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return body["message"] ?? "Registration failed. Please try again.";
      }
    } catch (e) {
      return "An error occurred. Please check your internet connection.";
    }
  }
}
