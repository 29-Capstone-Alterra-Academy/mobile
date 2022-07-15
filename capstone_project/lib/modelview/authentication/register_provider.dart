import 'dart:developer';

import 'package:capstone_project/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterProvider extends ChangeNotifier {
  final APIServices _apiServices = APIServices();
  bool obscurePassword = true;
  bool obscureConfirm = true;

  /// Change Password Obscure
  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  /// Change Confirm Password Obscure
  void changeObscureConfirm() {
    obscureConfirm = !obscureConfirm;
    notifyListeners();
  }

  /// Reset obscure password
  void resetObscure() {
    obscurePassword = true;
    obscureConfirm = true;
  }

  /// Register User
  Future registerUser({required String email, required String password}) async {
    // check email availability
    if (await _apiServices.checkEmail(email)) {
      log('email tersedia');
      var response = await _apiServices.registerUser(email, password);
      // if success register
      if (response.first == 'success') {
        final prefs = await SharedPreferences.getInstance();

        prefs.setString('access_token', response[1]);
        prefs.setString('refresh_token', response[2]);
      } else {
        // if failed register
        return '';
      }
    } else {
      return 'usedEmail';
    }
    // if failed register
    // return response.first;
  }
}
