import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone_project/viewmodel/splash_screen_viewmodel/splash_screen_provider.dart';

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
        } else if (provider.isLogin) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/navbar', (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        }
      });
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/nomizo-icon.png',
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 5,
        ),
      ),
    );
  }
}
