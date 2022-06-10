import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone_project/provider/bottom_navbar_provider.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavbarProvider>(context, listen: false);
    return Consumer<BottomNavbarProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: value.itemScreen[value.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: value.navbarItems,
            currentIndex: value.currentIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              provider.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
