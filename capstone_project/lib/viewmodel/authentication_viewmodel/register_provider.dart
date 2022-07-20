
import 'package:capstone_project/services/api_services.dart';
import 'package:flutter/cupertino.dart';

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
      if (await _apiServices.registerUser(email, password)) {
        // if success register
        return 'success';
      } else {
        // if failed register
        return '';
      }
    } else {
      return 'usedEmail';
    }
  }
}
