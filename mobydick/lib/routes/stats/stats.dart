import 'package:flutter/material.dart';
import 'package:mobydick/routes/home/trip_view.dart';
import 'package:mobydick/routes/stats/stats_source.dart';
import 'package:mobydick/services/trips_service.dart';
import '../../app_bar/AppBar.dart';
import '../../mobydick_app_theme.dart';
import '../../services/stats_service.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  StatsService tripService = StatsService();

  bool multiple = true;
  var trips = [];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    //futureTrips = tripService.fetchTripsByDay();

    setState(() {});

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
      appBar: ApplicationToolbar(title: "Stats"),
      backgroundColor: isLightMode == true
          ? MobydickAppTheme.white
          : MobydickAppTheme.nearlyBlack,
      body: ListView(
          scrollDirection: Axis.vertical, children: [PieChartSource()]),
      /*FutureBuilder<Map<String, List<Trip>>>(
        future: futureStats,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, List<Trip>>> snapshot) {
          if (!snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [],
            );
          } else {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [],
            );
          }
        },
      )*/
    );
  }
}
