import 'package:flutter/material.dart';
import 'package:travo_app/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travo_app/core/constants/color_palatte.dart';
import 'package:travo_app/core/helpers/local_storage_helper.dart';
import 'package:travo_app/representation/screens/splash_screen.dart.dart';

void main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travo',
      theme: ThemeData(
          primaryColor: ColorPalette.primaryColor,
          scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
          colorScheme: const ColorScheme.light(
              background: ColorPalette.backgroundScaffoldColor)),
      routes: routes,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
