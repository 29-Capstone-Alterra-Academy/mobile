import 'package:badges/badges.dart';
import 'package:capstone_project/modelview/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/modelview/bottom_navbar_provider.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProfileProvider>(context, listen: false).getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavbarProvider>(context, listen: false);
    return Consumer<BottomNavbarProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: value.itemScreen[value.currentIndex],
          bottomNavigationBar: Container(
            width: MediaQuery.of(context).size.width,
            height: 56,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: NomizoTheme.nomizoDark.shade100,
                ),
              ),
              color: NomizoTheme.nomizoDark.shade50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                // beranda
                navbarItem(
                  Icons.home,
                  Icons.home_outlined,
                  'Beranda',
                  0,
                  value.currentIndex,
                  () {
                    provider.changeIndex(0);
                  },
                ),
                // cari
                navbarItem(
                  Icons.search,
                  Icons.search_outlined,
                  'Cari',
                  1,
                  value.currentIndex,
                  () {
                    provider.changeIndex(1);
                  },
                ),
                // upload
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/upload');
                  },
                  child: Container(
                    width: 40,
                    height: 28,
                    decoration: BoxDecoration(
                      color: NomizoTheme.nomizoTosca.shade500,
                      border: Border.all(
                        color: NomizoTheme.nomizoTosca.shade50,
                        width: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.add,
                      color: NomizoTheme.nomizoDark.shade50,
                    ),
                  ),
                ),
                // notifikasi
                InkWell(
                  onTap: () {
                    provider.changeIndex(3);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Badge(
                        badgeColor: NomizoTheme.nomizoRed.shade600,
                        position: BadgePosition.topEnd(top: 0, end: 0),
                        child: value.currentIndex == 3
                            ? const Icon(Icons.notifications)
                            : const Icon(Icons.notifications_outlined),
                      ),
                      Text(
                        'Notifikasi',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: value.currentIndex == 3
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: value.currentIndex == 3
                                  ? NomizoTheme.nomizoDark.shade900
                                  : NomizoTheme.nomizoDark.shade500,
                            ),
                      ),
                    ],
                  ),
                ),
                // profil
                navbarItem(
                  Icons.person,
                  Icons.person_outline,
                  'Profil',
                  4,
                  value.currentIndex,
                  () {
                    provider.changeIndex(4);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget navbarItem(
    IconData selectedIcon,
    IconData unSelectedIcon,
    String label,
    int index,
    int currentIndex,
    void Function()? ontap,
  ) {
    return InkWell(
      onTap: ontap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          currentIndex == index ? Icon(selectedIcon) : Icon(unSelectedIcon),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight:
                      currentIndex == index ? FontWeight.w600 : FontWeight.w400,
                  color: currentIndex == index
                      ? NomizoTheme.nomizoDark.shade900
                      : NomizoTheme.nomizoDark.shade500,
                ),
          ),
        ],
      ),
    );
  }
}
