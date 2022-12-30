import 'package:flutter/material.dart';
import 'package:mobydick/routes/home/trip_view.dart';
import 'package:mobydick/services/trips_service.dart';
import '../main.dart';
import '../mobydick_app_theme.dart';
import '../bottom_navigation_view/bottom_bar_view.dart';
import '../models/tabIcon_data.dart';
import 'package:mobydick/globals.dart' as globals;

import '../models/trip_model.dart';
import '../models/trips_by_day_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
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
            return ListView(
              scrollDirection: Axis.vertical,
              children: List.generate(
                snapshot.data!.length,
                (index) {
                  return TripsView(tripsDay: snapshot.data?[index]);
                },
              ),
            );
          }
        },
      ),
    );
  }

  /*Future<void> _getTrips() async {
    TripService tripService = new TripService();

    var tripsResponse = await tripService.getNextTrips();
    if (tripsResponse == globals.INTERNET_CONNECTION_ERROR) {
      //globals.showInternetConnectionFailedDialog(context);
    } else {
      setState(() {
        trips = tripsResponse;
        print(trips.length);
      });
    }
  }*/
}
