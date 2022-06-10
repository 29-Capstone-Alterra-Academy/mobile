import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capstone_project/screens/bottom_navbar.dart';
import 'package:capstone_project/provider/bottom_navbar_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Nomizo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavbar(),
    );
  }
}
