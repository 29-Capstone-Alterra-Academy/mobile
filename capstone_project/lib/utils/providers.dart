import 'package:capstone_project/modelview/edit_profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:capstone_project/modelview/user_provider.dart';
import 'package:capstone_project/modelview/upload_provider.dart';
import 'package:capstone_project/modelview/profile_provider.dart';
import 'package:capstone_project/modelview/category_provider.dart';
import 'package:capstone_project/modelview/onboarding_provider.dart';
import 'package:capstone_project/modelview/home_screen_provider.dart';
import 'package:capstone_project/modelview/detail_thread_provider.dart';
import 'package:capstone_project/modelview/splash_screen_provider.dart';
import 'package:capstone_project/modelview/search_screen_provider.dart';
import 'package:capstone_project/modelview/bottom_navbar_provider.dart';
import 'package:capstone_project/modelview/create_category_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => SplashScreenProvider()),
  ChangeNotifierProvider(create: (_) => OnboardingProvider()),
  ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
  ChangeNotifierProvider(create: (_) => HomeScreenProvider()),
  ChangeNotifierProvider(create: (_) => SearchScreenProvider()),
  ChangeNotifierProvider(create: (_) => CategoryProvider()),
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => UploadProvider()),
  ChangeNotifierProvider(create: (_) => CreateCategoryProvider()),
  ChangeNotifierProvider(create: (_) => DetailThreadProvider()),
  ChangeNotifierProvider(create: (_) => ProfileProvider()),
  ChangeNotifierProvider(create: (_) => EditProfileProvider()),
];
