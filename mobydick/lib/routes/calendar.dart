import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobydick/drawer_menu/DrawerMenu.dart';
import 'package:mobydick/models/event_model.dart';
import 'package:mobydick/routes/home/trip_view.dart';
import 'package:mobydick/routes/view_booking.dart';
import 'package:mobydick/services/trips_service.dart';
import 'package:table_calendar/table_calendar.dart';
import '../app_bar/AppBar.dart';
import '../mobydick_app_theme.dart';

import '../models/trip_model.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  TripService tripService = TripService();

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  LinkedHashMap tripsByDay = new LinkedHashMap();
  bool pageReady = false;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    setState(() {
      tripService
          .fetchTripsInInterval("2023-01-27", "2023-07-27")
          .then((value) => setState(() {
                tripsByDay = value;
                pageReady = true;
                _selectedEvents.value = _getEventsForDay(_focusedDay);
              }));
      //futureTrips = tripService.fetchTripsByDay();
      _selectedDay = _focusedDay;
      _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    });

    super.initState();
  }

  List<Event> _getEventsForDay(DateTime day) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return tripsByDay[formatter.format(day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
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
      appBar: ApplicationToolbar(title: "Calendário"),
      backgroundColor: isLightMode == true
          ? MobydickAppTheme.white
          : MobydickAppTheme.nearlyBlack,
      body: Stack(
        children: [
          Visibility(visible: !pageReady, child: Text("Carregando")),
          Visibility(
            visible: pageReady,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: Column(/*scrollDirection: Axis.vertical, */ children: [
                TableCalendar<Event>(
                  locale: "pt_Pt",
                  firstDay: DateTime.utc(2023, 1, 1),
                  lastDay: DateTime.utc(2023, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    // Use `CalendarStyle` to customize the UI
                    outsideDaysVisible: false,
                  ),
                  onDaySelected: _onDaySelected,
                  //onRangeSelected: _onRangeSelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 8.0),
                Center(
                  child: const Text(
                    'Viagens',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: MobydickAppTheme.fontName,
                      fontWeight: FontWeight.w800,
                      fontSize: 21,
                      letterSpacing: 0.2,
                      color: MobydickAppTheme.darkText,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: calculateColor(value[index]),
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              onTap: () => {
                                /*Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (context) => ViewBookingScreen(
                                          tripId: value[index].pk)),
                                )*/

                                Navigator.pushNamed(context, 'tripDetails',
                                    arguments: {"id": value[index].pk})
                              },
                              title: Row(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.timer_outlined),
                                        Text(
                                          ' ${value[index]}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontFamily:
                                                MobydickAppTheme.fontName,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            letterSpacing: -0.2,
                                            color: MobydickAppTheme.darkText,
                                          ),
                                        ),
                                      ]),
                                  const SizedBox(width: 8.0),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(Icons.person),
                                        Text(
                                          '${value[index].occupancy} de ${value[index].capacity}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontFamily:
                                                MobydickAppTheme.fontName,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            letterSpacing: -0.2,
                                            color: MobydickAppTheme.darkText,
                                          ),
                                        ),
                                      ]),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  Color calculateColor(Event event) {
    double percentage = event.getOccupancyPercentage();
    if (percentage < 0.5) {
      return MobydickAppTheme.tripLowOccupancy;
    } else if (percentage < 0.85) {
      return MobydickAppTheme.tripMediumOccupancy;
    }
    return MobydickAppTheme.tripHighOccupancy;
  }
}
