import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobydick/app_bar/AppBar.dart';
import 'package:mobydick/mobydick_app_theme.dart';
import 'package:mobydick/models/ticket_model.dart';
import 'package:mobydick/services/booking_service.dart';
import 'package:mobydick/services/ticket_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:mobydick/globals.dart' as globals;

class TicketDetailDesktopPage extends StatefulWidget {
  Ticket ticket;
  TicketDetailDesktopPage({Key? key, required this.ticket}) : super(key: key);

  final state = _TicketDetailDesktopPage();

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class _TicketDetailDesktopPage extends State<TicketDetailDesktopPage> {
  final formKey = GlobalKey<FormState>();
  TicketService ticketService = TicketService();
  BookingService bookingService = BookingService();

  @override
  void initState() {
    print(widget.ticket.bookingClientModel.hotel.toString().isEmpty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
        appBar: ApplicationToolbar(title: "Bilhete"),
        backgroundColor: isLightMode == true
            ? MobydickAppTheme.white
            : MobydickAppTheme.nearlyBlack,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.height * 0.45,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Column(
                  // Vertically center the widget inside the column
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImage(
                      data: widget.ticket.ref,
                      version: QrVersions.auto,
                      size: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 11,
                      offset: Offset(1, 4), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              widget.ticket.ref,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: MobydickAppTheme.fontName,
                fontWeight: FontWeight.w700,
                fontSize: 17,
                letterSpacing: -0.2,
                color: MobydickAppTheme.darkText,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.06,
                  MediaQuery.of(context).size.height * 0.03,
                  0,
                  0),
              child: Row(
                children: [
                  Text(
                    "Nome: ",
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.lato(textStyle: MobydickAppTheme.topTable),
                  ),
                  Text(
                    widget.ticket.bookingClientModel.name.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.06,
                  MediaQuery.of(context).size.height * 0.02,
                  0,
                  0),
              child: Row(
                children: [
                  Text(
                    "Email: ",
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.lato(textStyle: MobydickAppTheme.topTable),
                  ),
                  Text(
                    widget.ticket.bookingClientModel.email.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.06,
                  MediaQuery.of(context).size.height * 0.02,
                  0,
                  0),
              child: Row(
                children: [
                  Text(
                    "Contacto: ",
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.lato(textStyle: MobydickAppTheme.topTable),
                  ),
                  Text(
                    widget.ticket.bookingClientModel.number.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
                  )
                ],
              ),
            ),
            Visibility(
              visible: widget.ticket.bookingClientModel.nationality
                  .toString()
                  .isNotEmpty,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.06,
                    MediaQuery.of(context).size.height * 0.02,
                    0,
                    0),
                child: Row(
                  children: [
                    Text(
                      "Nacionalidade : ",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: MobydickAppTheme.fontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        letterSpacing: -0.2,
                        color: MobydickAppTheme.darkText,
                      ),
                    ),
                    Text(
                      widget.ticket.bookingClientModel.nationality.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: MobydickAppTheme.fontName,
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        letterSpacing: -0.2,
                        color: MobydickAppTheme.dark_grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible: widget.ticket.bookingClientModel.hotel
                    .toString()
                    .isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.06,
                      MediaQuery.of(context).size.height * 0.02,
                      0,
                      0),
                  child: Row(
                    children: [
                      Text(
                        "Hotel : ",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: MobydickAppTheme.fontName,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          letterSpacing: -0.2,
                          color: MobydickAppTheme.darkText,
                        ),
                      ),
                      Text(
                        widget.ticket.bookingClientModel.hotel.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: MobydickAppTheme.fontName,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          letterSpacing: -0.2,
                          color: MobydickAppTheme.dark_grey,
                        ),
                      )
                    ],
                  ),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Stack(
              children: [
                Visibility(
                  visible: widget.ticket.state == "Pending",
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: Text("Confirmar checkin"),
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: Text(
                                      'Deseja fazer checkin do passageiro ${widget.ticket.bookingClientModel.name}?'),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Não"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      int result = await onCheckin(
                                        context,
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: Text("Check-in"),
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
                      Icons.check_circle_outline,
                      size: 17.0,
                    ),
                    label: Text(
                      'Efetuar Checking',
                      style: const TextStyle(
                        fontFamily: MobydickAppTheme.fontName,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                        letterSpacing: -0.2,
                      ),
                    ), // <-- Text
                  ),
                ),
                Visibility(
                  visible: widget.ticket.state == "Checkin",
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.check,
                          size: 30,
                          color: MobydickAppTheme.tripLowOccupancy,
                        ),
                        Text(
                          " Checkin Realizado",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: MobydickAppTheme.fontName,
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                            letterSpacing: -0.2,
                            color: Color.fromARGB(255, 12, 116, 72),
                          ),
                        ),
                      ]),
                )
              ],
            ),
          ],
        ));
  }

  Future<int> onCheckin(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Aguardando servidor");

    int response = await bookingService.checkin(widget.ticket.ref);
    if (response == 0) {
      setState(() {
        widget.ticket.state = "Checkin";
      });
    }

    pd.close();

    return response;
  }
}
