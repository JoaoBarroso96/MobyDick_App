import 'package:flutter/material.dart';

class MobydickAppTheme {
  MobydickAppTheme._();

  static const List<Color> statsColers = [
    Color.fromARGB(255, 253, 128, 111),
    Color.fromARGB(255, 178, 224, 97),
    Color.fromARGB(255, 126, 175, 213),
    Color.fromARGB(255, 189, 126, 190),
    Color.fromARGB(255, 255, 181, 90),
    Color.fromARGB(255, 255, 238, 101),
    Color.fromARGB(255, 190, 185, 219),
    Color.fromARGB(255, 253, 204, 229),
    Color.fromARGB(255, 139, 211, 199)
  ];

  static const Color pallet1 = Color.fromARGB(255, 42, 51, 73);
  static const Color pallet2 = Color.fromARGB(255, 86, 115, 148);
  static const Color pallet3 = Color.fromARGB(255, 159, 171, 194);
  static const Color pallet4 = Color.fromARGB(255, 200, 207, 220);
  static const Color pallet5 = Color.fromARGB(255, 234, 241, 245);
  static const Color white = /*Color.fromARGB(255, 246, 246, 245)*/ pallet5;
  static const Color white1 = Color(0xFFFFFFFF);

  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color.fromARGB(255, 168, 166, 166);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const Color tripLowOccupancy = Color.fromARGB(255, 2, 202, 102);
  static const Color tripMediumOccupancy = Color.fromARGB(255, 250, 200, 61);
  static const Color tripHighOccupancy = Color.fromARGB(255, 212, 60, 60);

  static const Color capacityColor = Color.fromARGB(255, 252, 171, 65);
  static const Color checkinColor = Color.fromARGB(255, 22, 164, 247);
  static const Color paymentColor = Color.fromARGB(255, 1, 151, 33);

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: pallet1,
  );

  static const TextStyle headline = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 31,
    letterSpacing: 0.27,
    color: nearlyBlack,
  );

  static const TextStyle topTable = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17,
    letterSpacing: 0.27,
    color: nearlyBlack,
  );

  static const TextStyle title = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: 0.18,
    color: pallet2,
  );

  static const TextStyle subtitle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 21,
    letterSpacing: 0.2,
    color: nearlyBlack,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle buttonBooking = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 21,
    letterSpacing: 0.2,
    color: Colors.white, // was lightText
  );
}
