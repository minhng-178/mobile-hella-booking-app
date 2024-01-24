import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travo_app/core/constants/color_palette.dart';
import 'package:travo_app/core/helpers/asset_helper.dart';

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration:
                BoxDecoration(gradient: Gradients.defaultGradientBackground),
            accountName: Text('User Name'),
            accountEmail: Text('useremail@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(AssetHelper.person),
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
              // Perform logout operation
              // ...
            },
          ),
        ],
      ),
    );
  }
}