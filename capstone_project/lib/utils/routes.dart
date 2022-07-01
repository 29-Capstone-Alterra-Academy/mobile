// import package
import 'package:flutter/cupertino.dart';

// import screen
import 'package:capstone_project/screens/bottom_navbar.dart';
import 'package:capstone_project/screens/auth_screen/login_screen.dart';
import 'package:capstone_project/screens/upload_screen/upload_screen.dart';
import 'package:capstone_project/screens/onboarding/onboarding_screen.dart';
import 'package:capstone_project/screens/search_screen/focused_search_screen.dart';
import 'package:capstone_project/screens/search_screen/popular_user/popular_category_screen.dart';
import 'package:capstone_project/screens/search_screen/popular_category/popular_category_screen.dart';

Route<dynamic>? nomizoRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return CupertinoPageRoute(
          builder: (_) => const BottomNavbar(), settings: settings);
    case '/onboard':
      return CupertinoPageRoute(
          builder: (_) => const OnboardingScreen(), settings: settings);
    case '/login':
      return CupertinoPageRoute(
          builder: (_) => const LoginScreen(), settings: settings);
    case '/upload':
      return CupertinoPageRoute(
          builder: (_) => const UploadScreen(), settings: settings);
    case '/search':
      return CupertinoPageRoute(
          builder: (_) => const FocusedSearchScreen(''), settings: settings);
    case '/popularCategory':
      return CupertinoPageRoute(
          builder: (_) => const PopularCategoryScreen(), settings: settings);
    case '/popularUser':
      return CupertinoPageRoute(
          builder: (_) => const PopularUserScreen(), settings: settings);
  }
  return null;
}
