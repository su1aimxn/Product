import 'dart:convert';
import 'package:flutter1/varbles.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$apiURL/api/auth/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "user_name": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        // Parse the user data using UserModel
        UserModel authResponse =
            UserModel.fromJson(jsonDecode(response.body));
        return {
          "success": true,
          "message": authResponse,
        };
      } else {
        // Failed login
        return {
          "success": false,
          "message": jsonDecode(response.body)['message'] ?? 'Login failed',
        };
      }
    } catch (err) {
      print('Error during login: $err');
      return {
        "success": false,
        "message": "An error occurred. Please try again.",
      };
    }
  }

  // Register function
  Future<void> register(String username, String password, String name, String role) async {
    final response = await http.post(
      Uri.parse("$apiURL/api/auth/register"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'user_name': username,
        'password': password,
        'name': name,
        'role': role,
      }),
    );

    print('Response body: ${response.body}');  // Print the response body

    if (response.statusCode == 201) {
      // If registration is successful, handle success (e.g., navigate to login page)
      print('User registered successfully');
      return; // No need to return UserModel if the response isn't JSON
    } else {
      throw Exception('Failed to register');
    }
  }
}
