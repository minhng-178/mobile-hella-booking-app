import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/providers/auth_user_provider.dart';
import 'package:travo_app/representation/widgets/app_bar_container.dart';
import 'package:travo_app/representation/widgets/item_elevated_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUserProvider>(context).user;

    return AppBarContainerWidget(
        titleString: 'Profile',
        implementLeading: false,
        implementTraling: true,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user?.photoURL ??
                      AssetHelper
                          .person), // Replace with your user's avatar image
                ),
                SizedBox(height: 20),
                Text(
                  user?.displayName ?? 'User Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Email: ${user?.email}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Phone: ${user?.phoneNumber}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                ItemElevatedButton(
                    variant: ButtonVariant.primary, title: 'Edit profile'),
              ],
            ),
          ),
        ));
  }
}
