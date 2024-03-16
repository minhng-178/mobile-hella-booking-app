import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';
import 'package:travo_app/representation/screens/booked_screen.dart';
import 'package:travo_app/representation/screens/comming_soon_screen.dart';
import 'package:travo_app/representation/screens/home_screen.dart';
import 'package:travo_app/representation/screens/profile_screen.dart';
import 'package:travo_app/representation/screens/tours_screen.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static const routeName = '/main_app';

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialogBox(context);
    });
  }

  void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ToursScreen.routeName);
                },
                child: Image.network(
                  'https://res.cloudinary.com/ddf1wvwlc/image/upload/v1710592386/Green_White_Minimalist_Tour_Travel_Pinterest_Pin_wsdkmv.png',
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          CommingsoonScreen(),
          BookedScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: ColorPalette.primaryColor,
        unselectedItemColor: ColorPalette.primaryColor.withOpacity(0.2),
        margin: EdgeInsets.symmetric(
            horizontal: kMediumPadding, vertical: kMediumPadding),
        items: [
          SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.house, size: kDefaultIconSize),
              title: Text('Home')),
          SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.solidHeart, size: kDefaultIconSize),
              title: Text('Likes')),
          SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.briefcase, size: kDefaultIconSize),
              title: Text('Booking')),
          SalomonBottomBarItem(
              icon: Icon(FontAwesomeIcons.solidUser, size: kDefaultIconSize),
              title: Text('Profile'))
        ],
      ),
    );
  }
}
