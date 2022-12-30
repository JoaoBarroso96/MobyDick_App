import 'package:flutter/material.dart';
import 'package:mobydick/models/trip_model.dart';
import '../../main.dart';
import '../../mobydick_app_theme.dart';
import '../../models/trips_by_day_model.dart';

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
    return Text(trip!.capacity);
  }
}
