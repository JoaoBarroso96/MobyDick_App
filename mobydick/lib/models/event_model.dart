import 'package:intl/intl.dart';
import 'package:mobydick/models/trip_model.dart';

class Event {
  int pk;
  String state;
  String boat;
  DateTime departure;
  int capacity;
  int occupancy;

  Event({
    required this.pk,
    required this.state,
    required this.boat,
    required this.departure,
    required this.capacity,
    required this.occupancy,
  });

  factory Event.fromTrip(Trip trip) {
    return Event(
        departure: trip.departure,
        pk: trip.pk,
        capacity: trip.capacity,
        state: trip.state,
        occupancy: trip.occupancy,
        boat: trip.boat);
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        departure: DateTime.parse(json['departure'] as String),
        pk: int.parse(json['pk'].toString()),
        capacity: int.parse(json['capacity'].toString()),
        state: json['state'].toString(),
        occupancy: int.parse(json['occupancy'].toString()),
        boat: json['boat'].toString());
  }

  double getOccupancyPercentage() {
    return occupancy / capacity;
  }

  @override
  String toString() {
    String time = DateFormat('HH:MM').format(departure);
    return time.toString();
  }
}
