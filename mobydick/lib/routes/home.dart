import 'package:flutter/material.dart';
import 'package:mobydick/routes/home/trip_view.dart';
import 'package:mobydick/services/trips_service.dart';
import '../mobydick_app_theme.dart';

import '../models/trip_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  TripService tripService = TripService();
  late Future<Map<String, List<Trip>>> futureTrips;

  bool multiple = true;
  var trips = [];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    //futureTrips = tripService.fetchTripsByDay();

    setState(() {
        futureTrips = tripService.fetchTripsByDay();
      });

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
      body: FutureBuilder<Map<String, List<Trip>>>(
        future: futureTrips,
        builder: (BuildContext context, AsyncSnapshot<Map<String, List<Trip>>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.1),
                child: const SizedBox(
                  child: Text("Home"),
                ));
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  snapshot.data!.length,
                  (index) {
                    return TripsView(
                        tripsDay: snapshot
                                .data![snapshot.data!.keys.toList()[index]] ??
                            []);
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
