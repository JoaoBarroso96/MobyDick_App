import 'package:flutter/material.dart';
import 'package:mobydick/routes/home/trip_view.dart';
import 'package:mobydick/services/trips_service.dart';
import '../mobydick_app_theme.dart';

import '../models/trips_by_day_model.dart';

class ViewBookingScreen extends StatefulWidget {
  const ViewBookingScreen({Key? key, this.tripId}) : super(key: key);

  final int? tripId;
  @override
  _ViewBookingState createState() => _ViewBookingState();
}

class _ViewBookingState extends State<ViewBookingScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  TripService tripService = TripService();
  late Future<List<TripsPerDay>> futureTrips;

  bool multiple = true;
  var trips = [];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    futureTrips = tripService.fetchTripsByDay();
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLightMode == true
          ? MobydickAppTheme.white
          : MobydickAppTheme.nearlyBlack,
      body: FutureBuilder<List<TripsPerDay>>(
        future: futureTrips,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    return TripsView(tripsDay: snapshot.data?[index]);
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
