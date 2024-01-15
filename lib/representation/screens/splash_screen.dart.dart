// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/core/helpers/image_helper.dart';
import 'package:travo_app/core/helpers/local_storage_helper.dart';
import 'package:travo_app/representation/screens/intro_screen.dart';
import 'package:travo_app/representation/screens/main_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirectIntroScreen();
  }

  void redirectIntroScreen() async {
    final igoreIntroScreen =
        LocalStorageHelper.getValue('ingoreIntroScreen') as bool?;
    await Future.delayed(const Duration(seconds: 2));

    if (igoreIntroScreen != null && igoreIntroScreen) {
      Navigator.of(context).pushNamed(MainApp.routeName);
    } else {
      LocalStorageHelper.setValue('ingoreIntroScreen', true);
      Navigator.of(context).pushNamed(IntroScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ImageHelper.loadFromAsset(AssetHelper.backgroundSplash,
              fit: BoxFit.fitWidth),
        ),
        Positioned.fill(
            child: ImageHelper.loadFromAsset(AssetHelper.circleSplash))
      ],
    );
  }
}
