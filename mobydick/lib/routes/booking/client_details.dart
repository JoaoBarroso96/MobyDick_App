import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../mobydick_app_theme.dart';
import '../../models/ticket_model.dart';

class BookingWidget extends StatelessWidget {
  BookingWidget({Key? key,
      required this.tickets})
      : super(key: key);

  final List<Ticket> tickets;

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.all(10.0),
    color: Color.fromARGB(255, 147, 220, 242),
    child: Padding(padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
    child: ExpandablePanel(
      header: Text(tickets[0].bookingClientModel.name.toString(),style: const TextStyle(
                fontFamily: MobydickAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 17,
                letterSpacing: -0.2,
                color: MobydickAppTheme.darkText,
              ),),
      collapsed: Text("${tickets.length} clientes", softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis,),
      expanded: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             for(var item in tickets ) TicketRowWidget(ticket: item)
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
}

class TicketRowWidget extends StatelessWidget {
  TicketRowWidget({Key? key,
      required this.ticket})
      : super(key: key);

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide( //                    <--- top side
            color: Color.fromARGB(255, 119, 119, 119),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
            Text(
              ticket.bookingClientModel.name.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: MobydickAppTheme.fontName,
                fontWeight: FontWeight.w100,
                fontSize: 15,
                letterSpacing: -0.2,
                color: MobydickAppTheme.darkText,
              ),
            ),
          ],
      ),

    );
  }
}