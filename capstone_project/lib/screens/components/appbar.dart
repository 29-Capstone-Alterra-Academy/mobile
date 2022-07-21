import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({Key? key, required this.logoImage}) : super(key: key);

  final String logoImage;

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        padding: const EdgeInsets.only(top: 44),
        child: Image.asset(
          logoImage,
          height: 58,
          width: 150,
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      toolbarHeight: 100,
    );
  }
}
