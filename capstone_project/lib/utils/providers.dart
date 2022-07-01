import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:capstone_project/modelview/onboarding_provider.dart';
import 'package:capstone_project/modelview/search_screen_provider.dart';
import 'package:capstone_project/modelview/bottom_navbar_provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => OnboardingProvider()),
  ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
  ChangeNotifierProvider(create: (_) => SearchScreenProvider()),

];
