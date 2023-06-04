import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobydick/services/trips_service.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../mobydick_app_theme.dart';

class Loading extends StatelessWidget {
  Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: SpinKitFadingFour(
              color: MobydickAppTheme.pallet2,
              size: 75.0,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.03),
            child: Image.asset(
              'assets/images/azornexus.png',
              width: 90,
              height: 90,
            ),
          ),
        ),
      ],
    );
  }
}
