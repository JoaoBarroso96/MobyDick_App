import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobydick/services/trips_service.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../mobydick_app_theme.dart';
import '../../models/ticket_model.dart';
import '../../models/trip_details_model.dart';
import 'package:intl/intl.dart';

import '../trip/trip_chart.dart';

class TripDetailsWidget extends StatefulWidget {
  TripDetailsWidget({Key? key, required this.tripDetails}) : super(key: key);

  final TripDetails tripDetails;
  final state = _TripDetailsWidget();

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class _TripDetailsWidget extends State<TripDetailsWidget> {
  TripService tripService = TripService();
  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt';
    List<int> countTicket = countPaymentsAndCheckin(widget.tripDetails.tickets);
    String capacity = "${countTicket[2]}/${widget.tripDetails.capacity}";
    String paymentStats = "${countTicket[1]}/${countTicket[2]}";
    String checkinStats = "${countTicket[0]}/${countTicket[2]}";
    String day = capitalize(
        DateFormat('EEEE, d MMMM, yyyy').format(widget.tripDetails.departure));
    return Column(
      children: [
        Visibility(
            visible: widget.tripDetails.state == "cancel",
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.warning,
                    color: MobydickAppTheme.capacityColor,
                    size: 37.0,
                  ),
                  Text(
                    "  Viagem Cancelada",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 27,
                      letterSpacing: 0.2,
                      color: MobydickAppTheme.capacityColor,
                    )),
                  ),
                ]))),
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
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.01),
              child: Text(
                "Overview",
                textAlign: TextAlign.left,
                style: GoogleFonts.quicksand(textStyle: MobydickAppTheme.title),
              ),
            )
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: BoxDecoration(
            color: MobydickAppTheme.pallet5,
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
            boxShadow: [
              BoxShadow(
                color: MobydickAppTheme.dark_grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(2, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    top: MediaQuery.of(context).size.height * 0.01),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.28,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Capacidade",
                        style: GoogleFonts.quicksand(
                            textStyle: MobydickAppTheme.topTable),
                      ),
                      Text(
                        capacity,
                        style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: -0.05,
                          color: MobydickAppTheme.capacityColor,
                        )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "Pagos",
                        style: GoogleFonts.quicksand(
                            textStyle: MobydickAppTheme.topTable),
                      ),
                      Text(
                        paymentStats,
                        style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: -0.05,
                          color: MobydickAppTheme.paymentColor,
                        )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Text(
                        "Checkin",
                        style: GoogleFonts.quicksand(
                            textStyle: MobydickAppTheme.topTable),
                      ),
                      Text(
                        checkinStats,
                        style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: -0.05,
                          color: MobydickAppTheme.checkinColor,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              TripChart(
                capacity: countTicket[2],
                payment: countTicket[1],
                checkin: countTicket[0],
                max: widget.tripDetails.capacity,
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Visibility(
                visible: widget.tripDetails.state != "cancel",
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            MobydickAppTheme.tripHighOccupancy)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: Text("Cancelar Viagem"),
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: Text(
                                      'Deseja cancelar a viagem? Todos passageiros serão notificados'),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Não"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      int result = await cancelTrip(
                                          context, widget.tripDetails.pk);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Sim"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
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
              ),
              Visibility(
                visible: widget.tripDetails.state != "cancel",
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            MobydickAppTheme.tripLowOccupancy)),
                    onPressed: () => Navigator.pushNamed(
                        context, 'createBooking', arguments: {
                      "tripId": widget.tripDetails.pk,
                      "bookingId": -1
                    }),
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
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.01),
              child: Text(
                "Reservas",
                textAlign: TextAlign.left,
                style: GoogleFonts.quicksand(textStyle: MobydickAppTheme.title),
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<int> cancelTrip(BuildContext context, int tripID) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Aguardando servidor");

    int response = await tripService.cancelTrip(tripID.toString());

    pd.close();
    if (response == 0) {
      setState(() {
        widget.tripDetails.state = "Cancel";
      });
    }

    return response;
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
