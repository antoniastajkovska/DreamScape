import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final Map<String, String> _users = {};

  String? _loggedInUserEmail;
  bool get isLoggedIn => _loggedInUserEmail != null;
  String? get loggedInUserEmail => _loggedInUserEmail;

  bool register(String email, String password) {
    if (_users.containsKey(email)) {
      return false; // email already in use
    }
    _users[email] = password;
    _loggedInUserEmail = null;
    notifyListeners();
    return true;
  }

  bool login(String email, String password) {
    if (_users[email] == password) {
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
