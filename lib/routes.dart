import 'package:flutter/material.dart';
import 'package:travo_app/models/booking_model.dart';
import 'package:travo_app/models/location_in_tour_model.dart';
import 'package:travo_app/models/trip_model.dart';
import 'package:travo_app/representation/screens/checkout_screen.dart';
import 'package:travo_app/representation/screens/comming_soon_screen.dart';
import 'package:travo_app/representation/screens/detail_tour_screen.dart';
import 'package:travo_app/representation/screens/intro_screen.dart';
import 'package:travo_app/representation/screens/login_screen.dart';
import 'package:travo_app/representation/screens/main_app.dart';
import 'package:travo_app/representation/screens/payment_method_screen.dart';
import 'package:travo_app/representation/screens/payment_success.dart';
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
  ToursScreen.routeName: (context) => const ToursScreen(),
  CommingsoonScreen.routeName: (context) => const CommingsoonScreen(),
};

MaterialPageRoute<dynamic>? generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case DetailTourScreen.routeName:
      final LocationInTourModel tourModel =
          (settings.arguments as LocationInTourModel);
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => DetailTourScreen(
          tourModel: tourModel,
        ),
      );

    case TourBookingScreen.routeName:
      final LocationInTourModel tourModel =
          (settings.arguments as LocationInTourModel);
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => TourBookingScreen(
          tourModel: tourModel,
        ),
      );

    case CheckOutScreen.routeName:
      final TripModel tripModel = (settings.arguments as TripModel);
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => CheckOutScreen(
          tripModel: tripModel,
        ),
      );

    case PaymentMethodScreen.routeName:
      final BookingModel bookingModel = (settings.arguments as BookingModel);
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => PaymentMethodScreen(bookingModel: bookingModel),
      );

    case PaymentSuccessScreen.routeName:
      final String queryString = (settings.arguments as String);
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (context) => PaymentSuccessScreen(queryString: queryString),
      );

    default:
      return null;
  }
}
