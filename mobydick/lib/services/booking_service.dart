import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobydick/globals.dart' as globals;
import '../models/booking_create_model.dart';

class BookingService {
  Future<int> addBooking(BookingCreateModel bookingCreateModel) async {
    try {
      final response = await http.post(
        Uri.parse("${globals.baseUrl}/booking/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bookingCreateModel),
      );
      if (response.statusCode == 201) {
        return 0;
      } else {
        return 1;
      }
    } on TimeoutException catch (_) {
      return 2;
    } on SocketException catch (_) {
      return 2;
    }
  }

  Future<int> checkin(String ref) async {
    try {
      final response = await http.put(
        Uri.parse("${globals.baseUrl}/ticket/$ref"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"checkin": true}),
      );
      if (response.statusCode == 201) {
        return 0;
      } else {
        return 1;
      }
    } on TimeoutException catch (_) {
      return 2;
    } on SocketException catch (_) {
      return 2;
    }
  }

  Future<int> payment(
    String ref,
    String method,
  ) async {
    try {
      final response = await http.put(
        Uri.parse("${globals.baseUrl}/booking/payment/$ref"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"paymentMethod": method}),
      );
      if (response.statusCode == 200) {
        return 0;
      } else {
        return 1;
      }
    } on TimeoutException catch (_) {
      return 2;
    } on SocketException catch (_) {
      return 2;
    }
  }
}
