import 'package:flutter/material.dart';
import 'package:travo_app/representation/screens/main_app.dart';
import 'package:travo_app/representation/widgets/item_button_widget.dart';

class CommingsoonScreen extends StatelessWidget {
  const CommingsoonScreen({super.key});

  static const routeName = '/comming_soon_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Coming Soon...',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Please check back later.',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0),
            ItemButtonWidget(
              onTap: () {
                Navigator.of(context).pushNamed(MainApp.routeName);
              },
              data: 'Go Back',
            ),
          ],
        ),
      ),
    );
  }
}
