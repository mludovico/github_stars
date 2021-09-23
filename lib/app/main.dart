import 'package:flutter/material.dart';
import 'package:github_stars/constants/routes.dart';
import 'package:github_stars/constants/theme.dart';
import 'package:github_stars/services/service_locators.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocators();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Stars',
      debugShowCheckedModeBanner: false,
      theme: kMainTheme,
      routes: kRoutes,
      initialRoute: kHomePage,
    );
  }
}
