import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobydick/routes/home/trip_view.dart';
import 'package:mobydick/services/trips_service.dart';
import '../app_bar/AppBar.dart';
import '../drawer_menu/DrawerMenu.dart';
import '../mobydick_app_theme.dart';
import '../models/trip_model.dart';
import 'loading/loading.dart';

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
      drawer: DrawerMenu(),
      appBar: ApplicationToolbar(title: "Home"),
      backgroundColor: isLightMode == true
          ? MobydickAppTheme.white
          : MobydickAppTheme.nearlyBlack,
      body: FutureBuilder<Map<String, List<Trip>>>(
        future: futureTrips,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, List<Trip>>> snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            return Stack(
              children: [
                Visibility(
                    visible: snapshot.data!.isNotEmpty,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: List.generate(
                        snapshot.data!.length,
                        (index) {
                          return TripsView(
                              tripsDay: snapshot.data![
                                      snapshot.data!.keys.toList()[index]] ??
                                  []);
                        },
                      ),
                    )),
                Visibility(
                    visible: snapshot.data!.isEmpty,
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Center(
                          child: Text(
                            "Sem Viagens",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.quicksand(
                                textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                              letterSpacing: 0.18,
                              color: MobydickAppTheme.pallet2,
                            )),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        Icon(
                          Icons.no_accounts,
                          color: MobydickAppTheme.pallet2,
                          size: 150.0,
                        ),
                      ],
                    ))
              ],
            );
          }
        },
      ),
    );
  }
}
