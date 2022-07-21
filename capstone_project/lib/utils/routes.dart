// import package

import 'package:capstone_project/screens/admin/moderator_screen/moderator_search_screen.dart';
import 'package:capstone_project/screens/profile_screen/edit_profile_screen.dart';
import 'package:capstone_project/screens/search_screen/search_history/seach_history_screen.dart';
import 'package:capstone_project/screens/upload_screen/select_category/create_category_screen.dart';
import 'package:flutter/cupertino.dart';

// import screen
import 'package:capstone_project/screens/splash_screen.dart';
import 'package:capstone_project/screens/bottom_navbar.dart';
import 'package:capstone_project/screens/auth_screen/login_screen.dart';
import 'package:capstone_project/screens/upload_screen/upload_screen.dart';
import 'package:capstone_project/screens/auth_screen/register_screen.dart';
import 'package:capstone_project/screens/onboarding/onboarding_screen.dart';
import 'package:capstone_project/screens/search_screen/focused_search_screen.dart';
import 'package:capstone_project/screens/search_screen/popular_user/search_user_screen.dart';
import 'package:capstone_project/screens/search_screen/detail_category/category_moderator_screen.dart';
import 'package:capstone_project/screens/search_screen/popular_user/popular_user_screen.dart';
import 'package:capstone_project/screens/search_screen/detail_category/contibutor_screen.dart';
import 'package:capstone_project/screens/auth_screen/reset_password/reset_password_screen.dart';
import 'package:capstone_project/screens/search_screen/detail_category/search_thread_screen.dart';
import 'package:capstone_project/screens/auth_screen/reset_password/code_verification_screen.dart';
import 'package:capstone_project/screens/upload_screen/select_category/select_category_screen.dart';
import 'package:capstone_project/screens/auth_screen/reset_password/email_verification_screen.dart';
import 'package:capstone_project/screens/search_screen/popular_category/search_category_screen.dart';
import 'package:capstone_project/screens/search_screen/popular_category/popular_category_screen.dart';
import 'package:capstone_project/screens/upload_screen/select_category/search_select_category_screen.dart';

Route<dynamic>? nomizoRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return CupertinoPageRoute(
          builder: (_) => const SplashScreen(), settings: settings);
    case '/navbar':
      return CupertinoPageRoute(
          builder: (_) => const BottomNavbar(), settings: settings);
    case '/onboard':
      return CupertinoPageRoute(
          builder: (_) => const OnboardingScreen(), settings: settings);
    case '/login':
      return CupertinoPageRoute(
          builder: (_) => const LoginScreen(), settings: settings);
    case '/register':
      return CupertinoPageRoute(
          builder: (_) => const RegisterScreen(), settings: settings);
    case '/verifiedEmail':
      return CupertinoPageRoute(
          builder: (_) => const VerificationEmailScreen(), settings: settings);
    case '/verifiedCode':
      return CupertinoPageRoute(
          builder: (_) => const VerificationCodeScreen(), settings: settings);
    case '/resetpassword':
      return CupertinoPageRoute(
          builder: (_) => const ResetPasswordScreen(), settings: settings);
    case '/upload':
      return CupertinoPageRoute(
          builder: (_) => const UploadScreen(), settings: settings);
    case '/search':
      return CupertinoPageRoute(
          builder: (_) => const FocusedSearchScreen(''), settings: settings);
    case '/searchHisotry':
      return CupertinoPageRoute(
          builder: (_) => const SearchHistoryScreen(), settings: settings);
    case '/popularCategory':
      return CupertinoPageRoute(
          builder: (_) => const PopularCategoryScreen(), settings: settings);
    case '/popularUser':
      return CupertinoPageRoute(
          builder: (_) => const PopularUserScreen(), settings: settings);
    case '/moderator':
      return CupertinoPageRoute(
          builder: (_) => const CategoryModeratorScreen(), settings: settings);
    case '/contributor':
      return CupertinoPageRoute(
          builder: (_) => const ContributorScreen(), settings: settings);
    case '/searchThread':
      return CupertinoPageRoute(
          builder: (_) => const SearchThreadScreen(), settings: settings);
    case '/searchCategory':
      return CupertinoPageRoute(
          builder: (_) => const SearchCategoryScreen(), settings: settings);
    case '/searchUser':
      return CupertinoPageRoute(
          builder: (_) => const SearchUserScreen(), settings: settings);
    case '/selectCategory':
      return CupertinoPageRoute(
          builder: (_) => const SelectCategoryScreen(), settings: settings);
    case '/searchSelectCategory':
      return CupertinoPageRoute(
          builder: (_) => const SearchSelectCategoryScreen(),
          settings: settings);
    case '/createCategory':
      return CupertinoPageRoute(
          builder: (_) => const CreateCategoryScreen(), settings: settings);
    case '/editProfile':
      return CupertinoPageRoute(
          builder: (_) => const EditProfileScreen(), settings: settings);
    case '/moderatorSearch':
      return CupertinoPageRoute(
          builder: (_) => const ModeratorSearchScreen(), settings: settings);
  }
  return null;
}
