import 'package:flutter/material.dart';
import 'package:capstone_project/screens/home_screen/home_screen.dart';
import 'package:capstone_project/screens/search_screen/search_screen.dart';
import 'package:capstone_project/screens/upload_screen/upload_screen.dart';
import 'package:capstone_project/screens/notification_screen/notification_screen.dart';
import 'package:capstone_project/screens/profile_screen/profile_screen.dart';

class BottomNavbarProvider extends ChangeNotifier {
  int currentIndex = 0;

  final List<Widget> itemScreen = [
    const HomeScreen(),
    const SearchScreen(),
    const UploadScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
