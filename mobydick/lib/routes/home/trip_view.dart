import 'package:flutter/material.dart';
import 'package:mobydick/models/trip_model.dart';
import '../../main.dart';
import '../../mobydick_app_theme.dart';
import 'package:intl/intl.dart';

import '../view_booking.dart';

class TripsView extends StatelessWidget {
  const TripsView(
      {Key? key,
      required this.tripsDay,
      this.animationController,
      this.animation})
      : super(key: key);

  final List<Trip> tripsDay;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String day = "";
    if (tripsDay.isNotEmpty) {
      day = formatter.format(tripsDay[0].departure);
    }

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Container(
            width: MediaQuery.of(context).size.width * 0.94,
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 183, 241, 255),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 13,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.013,
                  ),
                  Text(
                    day,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: MobydickAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 21,
                      letterSpacing: -0.2,
                      color: MobydickAppTheme.darkText,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.005,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          color: MobydickAppTheme.dark_grey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3.0)),
                        ),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      tripsDay.length,
                      (index) {
                        return TripDetail(trip: tripsDay[index]);
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ]))
      ],
    );
  }
}

class TripDetail extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Trip trip;

  // In the constructor, require a Todo.
  TripDetail({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${DateFormat.Hm().format(trip.departure)} - ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: MobydickAppTheme.fontName,
                        fontWeight: FontWeight.w800,
                        fontSize: 19,
                        letterSpacing: 0.5,
                        color: MobydickAppTheme.lightText,
                      ),
                    ),
                    Text(
                      "(${trip.occupancy}/${trip.capacity})",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: MobydickAppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        letterSpacing: 0.5,
                        color: calculateColor(),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  iconSize: 27,
                  color: MobydickAppTheme.nearlyBlue,
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              /*ViewBookingScreen(tripId: trip.pk)*/ SecondPage()),
                    );
                  },
                ),
              ],
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.03,
                    decoration: BoxDecoration(
                      color: HexColor('#F56E98').withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.8 *
                              trip.getOccupancyPercentage(),
                          height: MediaQuery.of(context).size.height * 0.03,
                          decoration: BoxDecoration(
                            color: MobydickAppTheme.nearlyBlue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ]),
    );
  }

  Color calculateColor() {
    double percentage = trip.getOccupancyPercentage();
    if (percentage < 0.5) {
      return MobydickAppTheme.tripLowOccupancy;
    } else if (percentage < 0.85) {
      return MobydickAppTheme.tripMediumOccupancy;
    }
    return MobydickAppTheme.tripHighOccupancy;
  }
}
