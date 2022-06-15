import 'package:capstone_project/screens/beranda/beranda_screen.dart';
import 'package:capstone_project/screens/cari/cari_screen.dart';
import 'package:capstone_project/screens/notifikasi/notifikasi_screen.dart';
import 'package:capstone_project/screens/profil/profil_screen.dart';
import 'package:capstone_project/screens/tambah/tambah_screen.dart';
import 'package:flutter/material.dart';

class BottomNavbarProvider extends ChangeNotifier {
  int currentIndex = 0;

  final List<Widget> itemScreen = [
    const BerandaScreen(),
    const CariScreen(),
    const TambahScreen(),
    const NotifikasiScreen(),
    const ProfilScreen(),
  ];

  final List<BottomNavigationBarItem> navbarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search_outlined),
      activeIcon: Icon(Icons.search),
      label: 'Cari',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications_outlined),
      activeIcon: Icon(Icons.notifications),
      label: 'Notifikasi',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_outlined),
      activeIcon: Icon(Icons.account_circle),
      label: 'Profil',
    ),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
