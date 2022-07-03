import 'package:capstone_project/modelview/splash_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SplashScreenProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 3), () async {
      await provider.getPreference().then((value) {
        if (provider.isOnboard!) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/onboard', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);

        }
      });
    });
    return Scaffold(
      body: Center(
        child: Image.asset('assets/img/app_logo.png'),
      ),
    );
  }
}