import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  final String _baseUrl = const String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:8080');

  String? _loggedInUserEmail;
  bool get isLoggedIn => _loggedInUserEmail != null;
  String? get loggedInUserEmail => _loggedInUserEmail;

  Future<bool> register(String fullName, String email, String password) async {
    final uri = Uri.parse('$_baseUrl/api/auth/register');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'fullName': fullName, 'email': email, 'password': password}),
    );
    if (res.statusCode == 200) {
      _loggedInUserEmail = null;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    final uri = Uri.parse('$_baseUrl/api/auth/login');
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (res.statusCode == 200) {
      _loggedInUserEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _loggedInUserEmail = null;
    notifyListeners();
  }
}
