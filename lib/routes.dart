import 'package:flutter/material.dart';
import 'package:travo_app/representation/screens/detail_tour_screen.dart';
import 'package:travo_app/representation/screens/intro_screen.dart';
import 'package:travo_app/representation/screens/login_screen.dart';
import 'package:travo_app/representation/screens/main_app.dart';
import 'package:travo_app/representation/screens/register_screen.dart';
import 'package:travo_app/representation/screens/splash_screen.dart.dart';
import 'package:travo_app/representation/screens/tour_booking_screen.dart';
import 'package:travo_app/representation/screens/tours_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainApp.routeName: (context) => const MainApp(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
  TourBookingScreen.routeName: (context) => TourBookingScreen(),
  ToursScreen.routeName: (context) => const ToursScreen(),
  DetailTourScreen.routeName: (context) => const DetailTourScreen()
};
