import 'package:flutter/material.dart';
import 'package:travo_app/representation/screens/hotel_booking_screen.dart';
import 'package:travo_app/representation/screens/intro_screen.dart';
import 'package:travo_app/representation/screens/main_app.dart';
import 'package:travo_app/representation/screens/select_date_screen.dart';
import 'package:travo_app/representation/screens/splash_screen.dart.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainApp.routeName: (context) => const MainApp(),
  HotelBookingScreen.routeName: (context) => const HotelBookingScreen(),
  SelectDateScreen.routeName: (context) => SelectDateScreen(),
};
