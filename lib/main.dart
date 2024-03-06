import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travo_app/core/helpers/size_config.dart';
import 'package:travo_app/firebase_options.dart';
import 'package:travo_app/routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:travo_app/providers/auth_user_provider.dart';
import 'package:travo_app/providers/dialog_provider.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/core/helpers/local_storage_helper.dart';
import 'package:travo_app/representation/screens/error_screen.dart';
import 'package:travo_app/representation/screens/splash_screen.dart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthUserProvider();
  final dialogProvider = DialogProvider();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  await authProvider.checkTokens();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => authProvider),
        ChangeNotifierProvider(create: (context) => dialogProvider),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // * This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hella',
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
        colorScheme: const ColorScheme.light(
            background: ColorPalette.backgroundScaffoldColor),
      ),
      routes: routes,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => ErrorScreen());
      },
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoutes,
      home: Builder(
        builder: (context) {
          SizeConfig.init(context);
          return SplashScreen();
        },
      ),
    );
  }
}
