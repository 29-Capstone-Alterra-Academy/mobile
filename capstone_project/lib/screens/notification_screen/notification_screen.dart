import 'package:flutter/material.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
      ),
      body: const NotificationUser(),
    );
  }
}

class NotificationUser extends StatelessWidget {
  const NotificationUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 14,
        ),
        child: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: NomizoTheme.nomizoTosca.shade600,
                //radius: 42, for size circleAvatar
                child: const Text('R'),
              ),
              title: Row(
                children: const [
                  Text(
                    '@username',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // Text('1 Jam yang lalu')
                ],
              ),
              subtitle: const Text(
                'Menyukai Postingan Kamu',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              minLeadingWidth: 5,
            ),
          ],
        ),
      ),
    );
  }
}
