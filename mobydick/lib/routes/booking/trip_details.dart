import 'package:flutter/material.dart';

import '../../mobydick_app_theme.dart';
import '../../models/ticket_model.dart';
import '../../models/trip_details_model.dart';
import 'package:intl/intl.dart';

class TripDetailsWidget extends StatelessWidget {
  TripDetailsWidget({Key? key, required this.tripDetails}) : super(key: key);

  final TripDetails tripDetails;

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt';
    List<int> countTicket = countPaymentsAndCheckin(tripDetails.tickets);
    String capacity = "${countTicket[2]}/${tripDetails.capacity}";
    String paymentStats = "${countTicket[1]}/${countTicket[2]}";
    String checkinStats = "${countTicket[0]}/${countTicket[2]}";
    String day = capitalize(
        DateFormat('EEEE, d MMMM, yyyy').format(tripDetails.departure));
    return Column(
      children: [
        Text(
          day,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: MobydickAppTheme.fontName,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: -0.2,
            color: MobydickAppTheme.darkerText,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Container(
          width: MediaQuery.of(context).size.height * 0.15,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: MobydickAppTheme.nearlyBlue,
              width: 4.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 27,
              ),
              Text(
                "Lotação",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: MobydickAppTheme.fontName,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: -0.2,
                  color: MobydickAppTheme.darkText,
                ),
              ),
              Text(
                capacity,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: MobydickAppTheme.fontName,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                  letterSpacing: -0.2,
                  color: MobydickAppTheme.darkText,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.height * 0.15,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: MobydickAppTheme.nearlyBlue,
                  width: 4.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.euro,
                    size: 27,
                  ),
                  Text(
                    "Pagam.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: MobydickAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: -0.2,
                      color: MobydickAppTheme.darkText,
                    ),
                  ),
                  Text(
                    paymentStats,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: MobydickAppTheme.fontName,
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      letterSpacing: -0.2,
                      color: MobydickAppTheme.darkText,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            Container(
              width: MediaQuery.of(context).size.height * 0.15,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: MobydickAppTheme.nearlyBlue,
                  width: 4.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                    size: 27,
                  ),
                  Text(
                    "Checkin",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: MobydickAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: -0.2,
                      color: MobydickAppTheme.darkText,
                    ),
                  ),
                  Text(
                    checkinStats,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: MobydickAppTheme.fontName,
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      letterSpacing: -0.2,
                      color: MobydickAppTheme.darkText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: tripDetails.state != "Cancel",
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        MobydickAppTheme.tripHighOccupancy)),
                onPressed: () {},
                icon: Icon(
                  // <-- Icon
                  Icons.cancel_outlined,
                  size: 17.0,
                ),
                label: Text(
                  'Cancelar Viagem',
                  style: const TextStyle(
                    fontFamily: MobydickAppTheme.fontName,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    letterSpacing: -0.2,
                  ),
                ), // <-- Text
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Visibility(
              visible: tripDetails.state != "Cancel",
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        MobydickAppTheme.tripLowOccupancy)),
                onPressed: () => Navigator.pushNamed(context, 'createBooking',
                    arguments: {"tripId": tripDetails.pk, "bookingId": -1}),
                icon: Icon(
                  // <-- Icon
                  Icons.add,
                  size: 17.0,
                ),
                label: Text(
                  'Adicionar Reserva',
                  style: const TextStyle(
                    fontFamily: MobydickAppTheme.fontName,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    letterSpacing: -0.2,
                  ),
                ), // <-- Text
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
          "Reservas",
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontFamily: MobydickAppTheme.fontName,
            fontWeight: FontWeight.w500,
            fontSize: 19,
            letterSpacing: -0.2,
            color: MobydickAppTheme.darkerText,
          ),
        ),
      ],
    );
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
List<int> countPaymentsAndCheckin(Map<int, List<Ticket>> tickets) {
  List<int> count = [0, 0, 0];

  for (List<Ticket> listT in tickets.values) {
    count[2] = count[2] + listT.length;
    for (Ticket t in listT) {
      if (t.state == "Checkin") {
        count[0]++;
      }
      if (t.paymentState != "none") {
        count[1]++;
      }
    }
  }
  return count;
}
