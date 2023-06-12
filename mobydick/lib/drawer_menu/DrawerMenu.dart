import 'package:flutter/material.dart';
import 'package:mobydick/routes/login/login_page.dart';
import '../mobydick_app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountEmail: Text('jane.doe@example.com'),
            accountName: Text(
              'Jane Doe',
              style: TextStyle(fontSize: 24.0),
            ),
            decoration: BoxDecoration(
              color: MobydickAppTheme.pallet2,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text(
              'About',
              style: TextStyle(fontSize: 24.0),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'stats');
            },
          ),
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
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }
}
