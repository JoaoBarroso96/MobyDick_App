import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobydick/models/trip_model.dart';
import 'package:mobydick/globals.dart' as globals;
import 'package:collection/collection.dart';
import '../models/trip_details_model.dart';

class TripService {
  Future<Map<String, List<Trip>>> fetchTripsByDay() async {
    final response = await http.get(Uri.parse("${globals.baseUrl}/trips"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

      List<Trip> trips =
          body.map<Trip>((jsonItem) => Trip.fromJson(jsonItem)).toList();

      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      Map<String, List<Trip>> groupedTripsByDay =
          groupBy(trips, (Trip item) => formatter.format(item.departure));
      return groupedTripsByDay;
      //return aggByDay(trips);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  /*List<TripsPerDay> aggByDay(List<Trip> trips) {
    String day = "";
    List<Trip> tripsSameDay = [];
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    List<TripsPerDay> tripsPerDay = [];
    for (var trip in trips) {
      String currentDay = formatter.format(trip.departure);

      if (day != currentDay && tripsSameDay.isNotEmpty) {
        tripsPerDay.add(TripsPerDay(day, tripsSameDay));
        tripsSameDay.clear();
      }
      day = currentDay;
      tripsSameDay.add(trip);
    }
    tripsPerDay.add(TripsPerDay(day, tripsSameDay));
    return tripsPerDay;
  }*/

  Future<TripDetails> fetchTripBookings(int idTrip) async {
    final response =
        await http.get(Uri.parse("${globals.baseUrl}/trip/details/$idTrip"));
    if (response.statusCode == 200) {
      TripDetails tripDetails =
          TripDetails.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return tripDetails;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
