import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../mobydick_app_theme.dart';
import 'package:mobydick/globals.dart' as globals;

class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget {
  String title = "";
  ApplicationToolbar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      title: Text(
        title,
        style: GoogleFonts.quicksand(textStyle: MobydickAppTheme.headline),
      ),
      actions: <Widget>[
        Visibility(
          visible: false,
          child: IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Icon',
            onPressed: () {},
          ),
        )
        //IconButton
      ], //<Widget>[]
      backgroundColor: MobydickAppTheme.pallet5,
      leading: IconButton(
        color: MobydickAppTheme.pallet1,
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
