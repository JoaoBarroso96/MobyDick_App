import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../mobydick_app_theme.dart';
import '../../models/ticket_model.dart';
import '../../services/booking_service.dart';

class BookingWidget extends StatefulWidget {
  final List<Ticket> tickets;
  final int tripID;
  final Function() onRefresh;
  BookingWidget(
      {Key? key,
      required this.tickets,
      required this.tripID,
      required this.onRefresh})
      : super(key: key);
  @override
  State createState() {
    return _BookingWidget();
  }
}

class _BookingWidget extends State<BookingWidget> {
  @override
  void initState() {
    super.initState();
  }

  BookingService bookingService = BookingService();

  String dropdownvalue = 'Dinheiro';
  var items = [
    'Dinheiro',
    'Transferência',
  ];

  @override
  Widget build(BuildContext context) {
    bool paid = widget.tickets[0].paymentState != "none";

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
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
      child: Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.03,
              0,
              MediaQuery.of(context).size.width * 0.03,
              MediaQuery.of(context).size.height * 0.005),
          child: ExpandablePanel(
            header: HeaderWidget(
                numberClients: widget.tickets.length.toString(),
                name: widget.tickets[0].bookingClientModel.name.toString(),
                paid: paid),
            collapsed: Text(
                widget.tickets[0].bookingClientModel.number.toString(),
                style: GoogleFonts.lato(textStyle: MobydickAppTheme.body2)),
            expanded: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FullBookingDetailsWidget(
                  ticket: widget.tickets[0],
                  onRefresh: widget.onRefresh,
                  tripID: widget.tripID,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        "Passageiro",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                            textStyle: MobydickAppTheme.topTable),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      child: Text(
                        "Contato",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                            textStyle: MobydickAppTheme.topTable),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.23,
                      child: Text(
                        "Checkin",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                            textStyle: MobydickAppTheme.topTable),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                for (var item in widget.tickets)
                  TicketRowWidget(
                    ticket: item,
                    tripId: widget.tripID,
                    onRefresh: widget.onRefresh,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.41,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.euro,
                          size: 21,
                        ),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.0,
                            color: MobydickAppTheme.pallet2,
                          ),
                          backgroundColor: MobydickAppTheme.white, // background
                          foregroundColor:
                              MobydickAppTheme.pallet2, // foreground
                        ),
                        onPressed: () {
                          if (widget.tickets[0].paymentState != "none") {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String contentText = "Content of Dialog";
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title: Text("Método Pagamento"),
                                      content: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        child: Column(
                                          children: [
                                            Text(
                                                'Qual o método pagamento utilizado?'),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02,
                                            ),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                isExpanded: true,
                                                // Initial Value
                                                value: dropdownvalue,
                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                // Array list of items
                                                items:
                                                    items.map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(items),
                                                  );
                                                }).toList(),
                                                onChanged: (String? value) {
                                                  // This is called when the user selects an item.
                                                  setState(() {
                                                    dropdownvalue = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            int result = await onPayment(
                                                context,
                                                widget
                                                    .tickets[0]
                                                    .bookingClientModel
                                                    .bookingId!
                                                    .toString(),
                                                dropdownvalue);

                                            if (result == 0) {
                                              //reload
                                              widget.onRefresh();
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Text("Change"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          }
                        },
                        label: Text(
                          'Pagar',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              textStyle: MobydickAppTheme.body1),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                        width: MediaQuery.of(context).size.width * 0.01),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.41,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.edit,
                          size: 19,
                        ),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            width: 1.0,
                            color: MobydickAppTheme.pallet2,
                          ),
                          elevation: 3,
                          backgroundColor: MobydickAppTheme.white, // background
                          foregroundColor:
                              MobydickAppTheme.pallet2, // foreground
                        ),
                        onPressed: () => Navigator.pushNamed(
                            context, 'createBooking',
                            arguments: {
                              "tripId": widget.tripID,
                              "bookingId":
                                  widget.tickets[0].bookingClientModel.bookingId
                            }),
                        label: Text(
                          'Editar',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              textStyle: MobydickAppTheme.body1),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            theme: const ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              tapBodyToCollapse: true,
              animationDuration: const Duration(milliseconds: 200),
            ),
          )),
    );
  }

  Future<int> onPayment(
      BuildContext context, String bookingId, String method) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Aguardando servidor");

    int response = await bookingService.payment(bookingId, method);
    pd.close();
    return response;
  }
}

class HeaderWidget extends StatelessWidget {
  HeaderWidget(
      {Key? key,
      required this.name,
      required this.numberClients,
      required this.paid})
      : super(key: key);

  final String name;
  final String numberClients;
  final bool paid;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            name,
            style: GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Icon(
            Icons.person_add,
            color: MobydickAppTheme.pallet2,
            size: 27.0,
          ),
          Text(
            " $numberClients",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
          ),
        ]),
        Stack(
          children: [
            Visibility(
              visible: paid,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      size: 20,
                      color: MobydickAppTheme.tripLowOccupancy,
                    ),
                    Text(
                      " Checked-in",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: MobydickAppTheme.fontName,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        letterSpacing: -0.2,
                        color: MobydickAppTheme.tripLowOccupancy,
                      ),
                    ),
                  ]),
            ),
            Visibility(
              visible: !paid,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.euro,
                      size: 20,
                      color: MobydickAppTheme.tripHighOccupancy,
                    ),
                    Text(
                      " Pending",
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
                    ),
                  ]),
            )
          ],
        )
      ],
    );
  }
}

class FullBookingDetailsWidget extends StatefulWidget {
  final Ticket ticket;
  final int tripID;
  final Function() onRefresh;

  FullBookingDetailsWidget(
      {Key? key,
      required this.ticket,
      required this.onRefresh,
      required this.tripID})
      : super(key: key);
  @override
  State createState() {
    return _FullBookingDetailsWidget();
  }
}

class _FullBookingDetailsWidget extends State<FullBookingDetailsWidget> {
  BookingService bookingService = BookingService();

  @override
  void initState() {
    super.initState();
  }

  void _update() {
    setState(() => widget.ticket.paymentState = "Money");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.mail,
                  size: 23,
                  color: MobydickAppTheme.pallet3,
                ),
                Text(
                  "  ${widget.ticket.bookingClientModel.email}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.hotel,
                  size: 23,
                  color: MobydickAppTheme.pallet3,
                ),
                Text(
                  "  ${widget.ticket.bookingClientModel.hotel}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.flag,
                  size: 23,
                  color: MobydickAppTheme.pallet3,
                ),
                Text(
                  "  ${widget.ticket.bookingClientModel.nationality}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.ads_click,
                  size: 23,
                  color: MobydickAppTheme.pallet3,
                ),
                Text(
                  "  ${widget.ticket.bookingClientModel.source}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(textStyle: MobydickAppTheme.body1),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02)
          ],
        ),
      ],
    );
  }
}

class TicketRowWidget extends StatelessWidget {
  TicketRowWidget(
      {Key? key,
      required this.ticket,
      required this.tripId,
      required this.onRefresh})
      : super(key: key);
  BookingService bookingService = BookingService();
  final Function() onRefresh;
  final Ticket ticket;
  final int tripId;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 119, 119, 119),
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Row(children: <Widget>[
                  Icon(Icons.man),
                  Text(
                    ticket.bookingClientModel.name.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(textStyle: MobydickAppTheme.body2),
                  ),
                ]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.23,
                child: Text(
                  ticket.bookingClientModel.number.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(textStyle: MobydickAppTheme.body2),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.23,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Visibility(
                            visible: ticket.state == "Pending",
                            child: IconButton(
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    String contentText = "Content of Dialog";
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return AlertDialog(
                                          title: Text("Confirmar checkin"),
                                          content: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            child: Text(
                                                'Deseja fazer checkin do passageiro ${ticket.bookingClientModel.name}?'),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text("Não"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                int result = await onCheckin(
                                                  context,
                                                );
                                                if (result == 0) {
                                                  //reload
                                                  onRefresh();
                                                }

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
                                size: 21.0,
                                color: MobydickAppTheme.pallet2,
                              ),
                              // <-- Text
                            ),
                          ),
                          Visibility(
                            visible: ticket.state == "Checkin",
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(
                                    Icons.check_box,
                                    size: 17,
                                    color: MobydickAppTheme.tripLowOccupancy,
                                  ),
                                  Text(
                                    " Realizado",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: MobydickAppTheme.fontName,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      letterSpacing: -0.2,
                                      color: MobydickAppTheme.tripLowOccupancy,
                                    ),
                                  ),
                                ]),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ));
  }

  Future<int> onCheckin(BuildContext context) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: "Aguarde");

    int response = await bookingService.checkin(ticket.ref);

    pd.close();

    return response;
    /* if (response == 0) {
      ticket.state = "Checkin";
    } else {}*/
  }
}
