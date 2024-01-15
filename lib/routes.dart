import 'package:flutter/material.dart';
import 'package:travo_app/representation/screens/intro_screen.dart';
import 'package:travo_app/representation/screens/main_app.dart';
import 'package:travo_app/representation/screens/splash_screen.dart.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainApp.routeName: (context) => const MainApp(),
};
