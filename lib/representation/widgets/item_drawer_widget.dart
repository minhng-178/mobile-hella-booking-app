import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';
import 'package:travo_app/providers/auth_user_provider.dart';
import 'package:travo_app/representation/screens/login_screen.dart';
import 'package:travo_app/representation/widgets/item_elevated_button.dart';

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUserProvider>(context).user;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration:
                BoxDecoration(gradient: Gradients.defaultGradientBackground),
            accountName: Text(user?.displayName ?? 'User Name'),
            accountEmail: Text(user?.email ?? 'useremail@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  NetworkImage(user?.photoURL ?? AssetHelper.person),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.inbox),
            title: Text('Inbox'),
            onTap: () {
              // Update the state of the app
              // ...
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.paperPlane),
            title: Text('Sent'),
            onTap: () {
              // Update the state of the app
              // ...
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.trashCan),
            title: Text('Trash'),
            onTap: () {
              // Update the state of the app
              // ...
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.gear),
            title: Text('Settings'),
            onTap: () {
              // Update the state of the app
              // ...
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.rightFromBracket),
            title: Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: ColorPalette.backgroundScaffoldColor,
                    surfaceTintColor: Colors.transparent,
                    title: Text('Logout'),
                    content: Text('Do you really want to logout?'),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ItemElevatedButton(
                            variant: ButtonVariant.secondary,
                            title: 'Cancel',
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ItemElevatedButton(
                            variant: ButtonVariant.primary,
                            title: 'Yes',
                            onPressed: () async {
                              final authProvider =
                                  Provider.of<AuthUserProvider>(context,
                                      listen: false);
                              final navigator = Navigator.of(context);

                              await authProvider.signOut();

                              navigator.pop();
                              navigator
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
