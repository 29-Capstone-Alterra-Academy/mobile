
import 'package:badges/badges.dart';
import 'package:capstone_project/screens/components/card_widget.dart';
import 'package:capstone_project/screens/components/nomizo_icons_icons.dart';
import 'package:capstone_project/utils/finite_state.dart';
import 'package:capstone_project/viewmodel/bottom_navbar_viewmodel/bottom_navbar_provider.dart';
import 'package:capstone_project/viewmodel/notification_viewmodel/notification_provider.dart';
import 'package:capstone_project/viewmodel/profile_viewmodel/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BottomNavbarProvider>(context, listen: false)
          .loadItemScreen();
      Provider.of<ProfileProvider>(context, listen: false).getProfile();
      Provider.of<BottomNavbarProvider>(context, listen: false)
          .loadItemScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavbarProvider>(context, listen: false);
    return Consumer<BottomNavbarProvider>(
      builder: (context, value, child) {
        if (value.state == FiniteState.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (value.itemScreen.isEmpty) {
            return Container();
          } else {
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
                child: value.isAdmin
                    ? adminNavbar(provider, value.currentIndex)
                    : userNavbar(provider, value.currentIndex),
              ),
            );
          }
        }
      },
    );
  }

  // Navbar Container (User)
  Widget userNavbar(BottomNavbarProvider provider, int currentIndex) {
    Provider.of<NotificationProvider>(context, listen: false)
        .getAllNotification();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        // beranda
        navbarItem(
          NomizoIcons.home,
          NomizoIcons.homeOutlined,
          'Beranda',
          0,
          currentIndex,
          () => provider.changeIndex(0),
        ),
        // cari
        navbarItem(
          Icons.search,
          Icons.search_outlined,
          'Cari',
          1,
          currentIndex,
          () => provider.changeIndex(1),
        ),
        // upload
        InkWell(
          onTap: () => Navigator.pushNamed(context, '/upload'),
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
          onTap: () => provider.changeIndex(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<NotificationProvider>(builder: (context, value, _) {
                if (value.notification.isNotEmpty) {
                  return Badge(
                    badgeColor: NomizoTheme.nomizoRed.shade600,
                    position: BadgePosition.topEnd(top: 0, end: 0),
                    child: currentIndex == 3
                        ? const Icon(Icons.notifications)
                        : const Icon(Icons.notifications_outlined),
                  );
                } else {
                  return currentIndex == 3
                      ? const Icon(Icons.notifications)
                      : const Icon(Icons.notifications_outlined);
                }
              }),
              Text(
                'Notifikasi',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight:
                          currentIndex == 3 ? FontWeight.w600 : FontWeight.w400,
                      color: currentIndex == 3
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
          currentIndex,
          () => provider.changeIndex(4),
        ),
      ],
    );
  }

  // Navbar Container (Admin)
  Widget adminNavbar(BottomNavbarProvider provider, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        // beranda
        navbarItem(
          NomizoIcons.home,
          NomizoIcons.homeOutlined,
          'Beranda',
          0,
          currentIndex,
          () => provider.changeIndex(0),
        ),
        // cari
        navbarItem(
          Icons.search,
          Icons.search_outlined,
          'Cari',
          1,
          currentIndex,
          () => provider.changeIndex(1),
        ),
        // moderator
        navbarItem(
          Icons.groups,
          Icons.groups_outlined,
          'Moderator',
          2,
          currentIndex,
          () => provider.changeIndex(2),
        ),
        // report
        InkWell(
          onTap: () => provider.changeIndex(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Badge(
                badgeColor: NomizoTheme.nomizoRed.shade600,
                position: BadgePosition.topEnd(top: 0, end: 0),
                child: currentIndex == 3
                    ? const Icon(NomizoIcons.report)
                    : const Icon(NomizoIcons.reportOutlined),
              ),
              Text(
                'Laporan',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight:
                          currentIndex == 3 ? FontWeight.w600 : FontWeight.w400,
                      color: currentIndex == 3
                          ? NomizoTheme.nomizoDark.shade900
                          : NomizoTheme.nomizoDark.shade500,
                    ),
              ),
            ],
          ),
        ),
        // log out
        navbarItem(
          NomizoIcons.logout,
          NomizoIcons.logoutOutlined,
          'Logout',
          4,
          currentIndex,
          () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return blockConfirmation(
                  context: context,
                  title: 'Ingin Keluar?',
                  subtitle:
                      'Apabila anda keluar dari akun ini, anda harus masuk kembali untuk dapat beridskusi di nomizo',
                  button1: 'Batal',
                  button2: 'Keluar',
                  function: () async {
                    Navigator.pop(context);
                    await provider.logOut().then(
                          (value) => Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          ),
                        );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  // Navbar Item
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
