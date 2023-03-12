
import 'package:flutter/material.dart';
import 'package:mobydick/services/trips_service.dart';
import '../mobydick_app_theme.dart';
import '../models/trip_details_model.dart';
import 'booking/client_details.dart';

class ViewBookingScreen extends StatefulWidget {
  var tripId;

  ViewBookingScreen({Key? key, this.tripId}) : super(key: key);

  @override
  _ViewBookingScreen createState() => _ViewBookingScreen(tripId: tripId);
}

class _ViewBookingScreen extends State<ViewBookingScreen>
    with TickerProviderStateMixin {
  _ViewBookingScreen({
    required this.tripId,
    this.animationController,
  });

  int tripId;
  AnimationController? animationController;
  TripService tripService = TripService();
  late Future<TripDetails> futureTripDetails;


  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    setState(() {
        futureTripDetails = tripService.fetchTripBookings(tripId);
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
    dispose();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLightMode == true
          ? MobydickAppTheme.white
          : MobydickAppTheme.nearlyBlack,
      body: FutureBuilder<TripDetails>(
        future: futureTripDetails,
        builder: (BuildContext context, AsyncSnapshot<TripDetails> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(child: Text("da"),);
          } else {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.15),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  snapshot.data!.tickets.length,
                  (index) {
                    return BookingWidget(
                        tickets: snapshot
                                .data!.tickets[snapshot.data!.tickets.keys.toList()[index]] ??
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

