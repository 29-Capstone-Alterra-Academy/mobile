import 'package:capstone_project/viewmodel/notification_viewmodel/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:provider/provider.dart';
import 'package:capstone_project/utils/finite_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NotificationProvider>(context, listen: false)
          .getAllNotification();
    });
    super.initState();
  }

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
    //final value = Provider.of<NotificationProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 14,
        ),
        child: Consumer<NotificationProvider>(
          builder:
              ((BuildContext context, NotificationProvider value, Widget? _) {
            if (value.state == FiniteState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: NomizoTheme.nomizoTosca.shade600,
                ),
              );
            }
            if (value.state == FiniteState.failed) {
              return const Center(
                child: Text('Something Wrong!!!'),
              );
            } else {
              if (value.notification.isEmpty) {
                return const Center(
                  child: Text('Tidak ada notifikasi terbaru'),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: value.notification.length,
                itemBuilder: (context, index) {
                  //final data = value.notification[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: NomizoTheme.nomizoTosca.shade600,
                      //radius: 42, for size circleAvatar
                      child: Image.asset(value.notification[index].image),
                    ),
                    title: Row(
                      children: [
                        Text(
                          value.notification[index].username,
                          style: const TextStyle(
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
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
