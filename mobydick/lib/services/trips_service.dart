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
    try {
    var response = await http.get(Uri.parse("${globals.baseUrl}/trips"));
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
      throw Exception('Error');
    }
    }catch (exception) {
      throw Exception('Error');
    }
    
  }



  Future<TripDetails> fetchTripBookings(int idTrip) async {
    final response = await http.get(Uri.parse("${globals.baseUrl}/trip/details/$idTrip"));
    try {
      if (response.statusCode == 200) {
      TripDetails tripDetails =
          TripDetails.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return tripDetails;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    } catch (exception) {
      throw Exception('Error');
    }
    
  }
}
