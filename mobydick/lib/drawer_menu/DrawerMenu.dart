import 'package:flutter/material.dart';
import 'package:mobydick/routes/login/login_page.dart';
import '../mobydick_app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobydick/globals.dart' as globals;

class DrawerMenu extends StatelessWidget {
  DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(globals.email.toString()),
            accountName: Text(
              globals.name.toString(),
              style: TextStyle(fontSize: 24.0),
            ),
            decoration: BoxDecoration(
              color: MobydickAppTheme.pallet2,
            ),
          ),
          /*ListTile(
            leading: const Icon(Icons.info),
            title: const Text(
              'About',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'stats');
            },
          ),*/
          const Divider(
            height: 10,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              _logout(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamed(context, 'logout');
  }

}
