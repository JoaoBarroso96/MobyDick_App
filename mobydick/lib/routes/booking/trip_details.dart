import 'package:flutter/material.dart';

import '../../mobydick_app_theme.dart';
import '../../models/trip_details_model.dart';
import 'package:intl/intl.dart';

class TripDetailsWidget extends StatelessWidget {
  TripDetailsWidget({Key? key, required this.tripDetails}) : super(key: key);

  final TripDetails tripDetails;

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt';
    String day = capitalize(
        DateFormat('EEEE, d MMMM, yyyy').format(tripDetails.departure));
    return Column(
      children: [
        Text(
          day,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: MobydickAppTheme.fontName,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: -0.2,
            color: MobydickAppTheme.darkerText,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Container(
          width: MediaQuery.of(context).size.height * 0.15,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: MobydickAppTheme.nearlyBlue,
              width: 4.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 27,
              ),
              Text(
                "Lotação",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: MobydickAppTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: -0.2,
                  color: MobydickAppTheme.darkText,
                ),
              ),
              Text(
                "15 / 20",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: MobydickAppTheme.fontName,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                  letterSpacing: -0.2,
                  color: MobydickAppTheme.darkText,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.height * 0.15,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: MobydickAppTheme.nearlyBlue,
                  width: 4.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.euro,
                    size: 27,
                  ),
                  Text(
                    "Pagam.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: MobydickAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: -0.2,
                      color: MobydickAppTheme.darkText,
                    ),
                  ),
                  Text(
                    "15 / 20",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: MobydickAppTheme.fontName,
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      letterSpacing: -0.2,
                      color: MobydickAppTheme.darkText,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            Container(
              width: MediaQuery.of(context).size.height * 0.15,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: MobydickAppTheme.nearlyBlue,
                  width: 4.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                    size: 27,
                  ),
                  Text(
                    "Checkin",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: MobydickAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: -0.2,
                      color: MobydickAppTheme.darkText,
                    ),
                  ),
                  Text(
                    "15 / 20",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: MobydickAppTheme.fontName,
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      letterSpacing: -0.2,
                      color: MobydickAppTheme.darkText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
          "Reservas",
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontFamily: MobydickAppTheme.fontName,
            fontWeight: FontWeight.w500,
            fontSize: 19,
            letterSpacing: -0.2,
            color: MobydickAppTheme.darkerText,
          ),
        ),
      ],
    );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
