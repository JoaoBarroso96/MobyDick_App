import 'package:mobydick/models/ticket_model.dart';

class TripDetails {
  int pk;
  String state;
  String boat;
  DateTime departure;
  int capacity;
  int occupancy;
  List<Ticket> tickets;

  TripDetails({
    required this.pk,
    required this.state,
    required this.boat,
    required this.departure,
    required this.capacity,
    required this.occupancy,
    required this.tickets,
  });

  factory TripDetails.fromJson(Map<String, dynamic> json) {
    List body = json['tickets'] as List;
    List<Ticket> tempTickets =
        body.map((dynamic jsonItem) => Ticket.fromJson(jsonItem)).toList();

    return TripDetails(
        departure: DateTime.parse(json['departure'] as String),
        pk: int.parse(json['pk'].toString()),
        capacity: int.parse(json['capacity'].toString()),
        state: json['state'].toString(),
        occupancy: int.parse(json['occupancy'].toString()),
        tickets: tempTickets,
        boat: json['boat'].toString());
  }

  double getOccupancyPercentage() {
    return occupancy / capacity;
  }
}
