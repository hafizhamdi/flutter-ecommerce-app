import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../constants/constant.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Text("Shopping Mart",
                style: TextStyle(
                    color: kPrimaryTextColor,
                    fontSize: 28,
                    fontWeight: kFontWeight700)),
          ),
          ListTile(
            title: const Text('About'),
            onTap: () {
              showAboutDialog(
                  context: context,
                  applicationName: "Shopping Mart",
                  applicationVersion: "Build for Femmily Assesment 2023",
                  applicationIcon: Icon(PhosphorIcons.regular.rocketLaunch));
              // Update the state of the app.
              // ...
            },
          )
        ]));
  }
}
