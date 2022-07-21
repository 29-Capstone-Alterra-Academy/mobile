import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:capstone_project/viewmodel/user_viewmodel/user_provider.dart';
import 'package:capstone_project/viewmodel/thread_viewmodel/upload_provider.dart';
import 'package:capstone_project/viewmodel/profile_viewmodel/profile_provider.dart';
import 'package:capstone_project/viewmodel/admin_viewmodel/admin_home_provider.dart';
import 'package:capstone_project/viewmodel/home_viewmodel/home_screen_provider.dart';
import 'package:capstone_project/viewmodel/category_viewmodel/category_provider.dart';
import 'package:capstone_project/viewmodel/admin_viewmodel/admin_report_provider.dart';
import 'package:capstone_project/viewmodel/search_viewmodel/search_user_provider.dart';
import 'package:capstone_project/viewmodel/profile_viewmodel/edit_profile_provider.dart';
import 'package:capstone_project/viewmodel/authentication_viewmodel/login_provider.dart';
import 'package:capstone_project/viewmodel/search_viewmodel/search_screen_provider.dart';
import 'package:capstone_project/viewmodel/thread_viewmodel/detail_thread_provider.dart';
import 'package:capstone_project/viewmodel/search_viewmodel/search_history_provider.dart';
import 'package:capstone_project/viewmodel/admin_viewmodel/admin_moderator_provider.dart';
import 'package:capstone_project/viewmodel/onboarding_viewmodel/onboarding_provider.dart';
import 'package:capstone_project/viewmodel/authentication_viewmodel/register_provider.dart';
import 'package:capstone_project/viewmodel/category_viewmodel/create_category_provider.dart';
import 'package:capstone_project/viewmodel/notification_viewmodel/notification_provider.dart';
import 'package:capstone_project/viewmodel/bottom_navbar_viewmodel/bottom_navbar_provider.dart';
import 'package:capstone_project/viewmodel/splash_screen_viewmodel/splash_screen_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
  ChangeNotifierProvider(create: (_) => OnboardingProvider()),
  ChangeNotifierProvider(create: (_) => LoginProvider()),
  ChangeNotifierProvider(create: (_) => RegisterProvider()),
  ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
  ChangeNotifierProvider(create: (_) => AdminHomeProvider()),
  ChangeNotifierProvider(create: (_) => AdminModeratorProvider()),
  ChangeNotifierProvider(create: (_) => AdminReportProvider()),
  ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
  ChangeNotifierProvider(create: (_) => SearchScreenProvider()),
  ChangeNotifierProvider(create: (_) => SearchUserProvider()),
  ChangeNotifierProvider(create: (_) => SearchHistoryProvider()),
  ChangeNotifierProvider(create: (_) => CategoryProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => UploadProvider()),
  ChangeNotifierProvider(create: (_) => CreateCategoryProvider()),
  ChangeNotifierProvider(create: (_) => DetailThreadProvider()),
  ChangeNotifierProvider(create: (_) => ProfileProvider()),
  ChangeNotifierProvider(create: (_) => EditProfileProvider()),
  ChangeNotifierProvider(create: (_) => NotificationProvider())
];
