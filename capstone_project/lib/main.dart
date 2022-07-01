// import package
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

// import screen file
import 'package:capstone_project/screen/auth_screen/login_screen.dart';
import 'package:capstone_project/screen/home_screen/home_screen.dart';
import 'package:capstone_project/screen/auth_screen/register_screen.dart';
import 'screen/auth_screen/reset_password/email_verification_screen.dart';
import 'screen/auth_screen/reset_password/code_verification_screen.dart';
import 'screen/auth_screen/reset_password/reset_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.white,
        fontFamily: 'Inter',
      ),
      initialRoute: '/login',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(
                builder: (_) => const HomeScreen(), settings: settings);
          case '/login':
            return CupertinoPageRoute(
                builder: (_) => const LoginScreen(), settings: settings);
          case '/register':
            return CupertinoPageRoute(
                builder: (_) => const RegisterScreen(), settings: settings);
          case '/verifiedEmail':
            return CupertinoPageRoute(
                builder: (_) => const VerificationEmailScreen(),
                settings: settings);
          case '/verifiedCode':
            return CupertinoPageRoute(
                builder: (_) => const VerificationCodeScreen(),
                settings: settings);
          case '/resetpassword':
            return CupertinoPageRoute(
                builder: (_) => const ResetPasswordScreen(),
                settings: settings);
        }
        return null;
      },
    );
  }
}
