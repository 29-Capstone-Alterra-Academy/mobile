// import package
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

// import utils & theme
import 'package:capstone_project/utils/routes.dart';
import 'package:capstone_project/utils/providers.dart';
import 'package:capstone_project/themes/nomizo_theme.dart';
import 'package:capstone_project/screens/components/custom_timeago_message.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
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
    // Override "en" locale messages with custom messages that are more precise and short
    timeago.setLocaleMessages('id', MyCustomMessages());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Nomizo',
      theme: NomizoTheme.nomizoTheme,
      initialRoute: '/',
      onGenerateRoute: nomizoRoutes,
    );
  }
}
