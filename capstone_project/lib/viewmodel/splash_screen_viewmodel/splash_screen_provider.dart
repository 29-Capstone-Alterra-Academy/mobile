import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenProvider extends ChangeNotifier {
  bool? isOnboard;
  bool isLogin = false;

  Future getPreference() async {
    final prefs = await SharedPreferences.getInstance();
    isOnboard = prefs.getBool('isOnboard') ?? true;
    isLogin = prefs.getString('access_token') != null ? true : false;
    if (isOnboard == true) {
      await prefs.setBool('isOnboard', false);
    }
    notifyListeners();
  }
}
