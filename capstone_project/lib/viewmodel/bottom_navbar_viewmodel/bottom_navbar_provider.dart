import 'package:capstone_project/screens/admin/home_screen/admin_home_screen.dart';
import 'package:capstone_project/screens/admin/moderator_screen/moderator_screen.dart';
import 'package:capstone_project/screens/admin/report_screen/report_screen.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/screens/home_screen/home_screen.dart';
import 'package:capstone_project/screens/search_screen/search_screen.dart';
import 'package:capstone_project/screens/upload_screen/upload_screen.dart';
import 'package:capstone_project/screens/notification_screen/notification_screen.dart';
import 'package:capstone_project/screens/profile_screen/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavbarProvider extends ChangeNotifier {
  FiniteState state = FiniteState.none;
  int currentIndex = 0;
  bool isAdmin = false;

  late List<Widget> itemScreen = [];

  // Load Item Screen
  void loadItemScreen() async {
    final prefs = await SharedPreferences.getInstance();
    isAdmin = prefs.getBool('isAdmin') ?? false;

    changeState(FiniteState.loading);
    if (isAdmin) {
      itemScreen = [
        const AdminHomeScreen(),
        const SearchScreen(),
        const ModeratorScreen(),
        const ReportScreen(),
      ];
    } else {
      itemScreen = [
        const HomeScreen(),
        const SearchScreen(),
        const UploadScreen(),
        const NotificationScreen(),
        const ProfileScreen(),
      ];
    }
    changeState(FiniteState.none);
  }

  // Change ItemScreen Index
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  // CHANGE MAIN STATE
  void changeState(FiniteState s) {
    state = s;
    notifyListeners();
  }

  Future logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('isAdmin');
    prefs.remove('access_token');
    prefs.remove('refresh_token');
    currentIndex = 0;
  }
}
