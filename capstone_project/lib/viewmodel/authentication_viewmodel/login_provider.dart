import 'dart:convert';

import 'package:capstone_project/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();
  bool obscurePassword = true;

  /// Change Password Obscure
  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  /// Reset obscure password
  void resetObscure() {
    obscurePassword = true;
  }

  Future<bool> loginUser(String email, String password) async {
    var response = await _apiServices.postLogin(email, password);
    // if success login
    if (response.first == 'success') {
      final prefs = await SharedPreferences.getInstance();

      prefs.setString('access_token', response[1]);
      prefs.setString('refresh_token', response[2]);

      Map<String, dynamic> code = await parseJwt(response[1]);
      bool admin = code['IsAdmin'];
      if (admin) {
        prefs.setBool('isAdmin', true);
      }
      return true;
    } else {
      // if failed login
      return false;
    }
  }

  Future<Map<String, dynamic>> parseJwt(String token) async {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = await _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  Future<String> _decodeBase64(String str) async {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
