import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobydick/models/trip_model.dart';
import 'package:mobydick/globals.dart' as globals;
import 'package:mobydick/models/trips_by_day_model.dart';

class TripService {
  Future<List<TripsPerDay>> fetchTripsByDay() async {
    final response = await http.get(Uri.parse("${globals.baseUrl}/trips"));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

      List<Trip> trips =
          body.map<Trip>((jsonItem) => Trip.fromJson(jsonItem)).toList();
      return aggByDay(trips);
    } else {
      print("casa");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  List<TripsPerDay> aggByDay(List<Trip> trips) {
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
    print(tripsPerDay);
    return tripsPerDay;
  }
}
