import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final DateFormat formatter = DateFormat('dd MMMM yyyy', 'pt');
    String day = "";
    if (tripsDay.isNotEmpty) {
      day = formatter.format(tripsDay[0].departure);
    }

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.01),
              child: Text(
                day,
                textAlign: TextAlign.left,
                style: GoogleFonts.quicksand(textStyle: MobydickAppTheme.title),
              ),
            )
          ],
        ),
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
      decoration: BoxDecoration(
        color: MobydickAppTheme.pallet5,
        borderRadius: BorderRadius.all(Radius.circular(2)),
        boxShadow: [
          BoxShadow(
            color: MobydickAppTheme.dark_grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(2, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.04,
          right: MediaQuery.of(context).size.width * 0.04,
          bottom: MediaQuery.of(context).size.height * 0.03),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.04,
            MediaQuery.of(context).size.height * 0.01,
            MediaQuery.of(context).size.width * 0.04,
            MediaQuery.of(context).size.height * 0.02),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        color: MobydickAppTheme.pallet2,
                        size: 27.0,
                      ),
                      Text(
                        "  ${DateFormat.Hm().format(trip.departure)}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                            textStyle: MobydickAppTheme.subtitle),
                      ),
                      Text(
                        "  (${trip.occupancy}/${trip.capacity})",
                        textAlign: TextAlign.left,
                        style:
                            GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
                      ),
                    ],
                  ),
                  IconButton(
                    iconSize: 27,
                    color: MobydickAppTheme.pallet2,
                    icon: const Icon(Icons.visibility),
                    onPressed: () => Navigator.pushNamed(context, 'tripDetails',
                        arguments: {"id": trip.pk}),
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
                      width: MediaQuery.of(context).size.width * 0.92,
                      height: MediaQuery.of(context).size.height * 0.03,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MobydickAppTheme.pallet2,
                        ),
                        color: HexColor('#F56E98').withOpacity(0),
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      child: Row(
                        children: <Widget>[
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    0.92 *
                                    trip.getOccupancyPercentage(),
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                                decoration: BoxDecoration(
                                  color: MobydickAppTheme.pallet2,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.0)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.88 *
                                      trip.getOccupancyPercentage(),
                                ),
                                child: Icon(
                                  Icons.directions_boat_filled,
                                  color: MobydickAppTheme.pallet1,
                                  size: 35.0,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
            ]),
      ),
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
