import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobydick/app_bar/AppBar.dart';
import 'package:mobydick/mobydick_app_theme.dart';
import 'package:mobydick/models/ticket_model.dart';
import 'package:mobydick/routes/ticket/ticket_detail_desktop.dart';
import 'package:mobydick/routes/ticket/ticket_detail_mobile.dart';
import 'package:mobydick/services/booking_service.dart';
import 'package:mobydick/services/ticket_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:mobydick/globals.dart' as globals;

class TicketDetailPage extends StatefulWidget {
  Ticket ticket;
  TicketDetailPage({Key? key, required this.ticket}) : super(key: key);

  final state = _TicketDetailPage();

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class _TicketDetailPage extends State<TicketDetailPage> {
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > globals.mobileWith) {
          return TicketDetailDesktopPage(ticket: widget.ticket);
        } else {
          return TicketDetailMobilePage(ticket: widget.ticket);
        }
      },
    );
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

    /* if (response == 0) {
      ticket.state = "Checkin";
    } else {}*/
  }
}
