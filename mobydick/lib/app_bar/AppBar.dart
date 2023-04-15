import 'package:flutter/material.dart';

import '../mobydick_app_theme.dart';
import 'package:mobydick/globals.dart' as globals;

class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget {
  String title = "";
  ApplicationToolbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: MobydickAppTheme.fontName,
          fontWeight: FontWeight.w500,
          fontSize: 25,
          letterSpacing: 0.5,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search Icon',
          onPressed: () {},
        ), //IconButton
      ], //<Widget>[]
      backgroundColor: MobydickAppTheme.nearlyDarkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
      ),
      elevation: 5.0,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        tooltip: 'Menu Icon',
        onPressed: () {
          globals.key.currentState!.openDrawer();
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
