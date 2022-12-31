import 'package:flutter/material.dart';
import 'package:mobydick/models/trip_model.dart';
import '../../main.dart';
import '../../mobydick_app_theme.dart';
import '../../models/trips_by_day_model.dart';
import 'package:intl/intl.dart';

class TripsView extends StatelessWidget {
  const TripsView(
      {Key? key, this.tripsDay, this.animationController, this.animation})
      : super(key: key);

  final TripsPerDay? tripsDay;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            tripsDay!.day,
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
                  borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              tripsDay!.trips.length,
              (index) {
                return TripDetail(trip: tripsDay!.trips[index]);
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
        ]);
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
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${DateFormat.Hm().format(trip.departure)} - ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: MobydickAppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    letterSpacing: 0.5,
                    color: MobydickAppTheme.lightText,
                  ),
                ),
                Text(
                  "(${trip.occupancy}/${trip.capacity})",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: MobydickAppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    letterSpacing: 0.5,
                    color: calculateColor(),
                  ),
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
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.03,
                    decoration: BoxDecoration(
                      color: HexColor('#F56E98').withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.7 *
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
