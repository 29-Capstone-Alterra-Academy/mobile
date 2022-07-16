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

      if (email == 'abdul123@gmail.com') {
        prefs.setBool('isAdmin', true);
      }

      return true;
    } else {
      // if failed login
      return false;
    }
  }
}
