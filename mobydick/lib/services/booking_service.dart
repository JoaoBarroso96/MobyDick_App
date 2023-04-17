import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobydick/globals.dart' as globals;
import 'package:mobydick/models/booking_client_model.dart';
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

  Future<int> updateBooking(
      BookingCreateModel bookingCreateModel, int idBooking) async {
    try {
      final response = await http.patch(
        Uri.parse("${globals.baseUrl}/booking/$idBooking"),
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

  Future<List<BookingClientModel>> bookingDetails(int idBooking) async {
    try {
      final response = await http.get(
        Uri.parse("${globals.baseUrl}/booking/details/$idBooking"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        List<BookingClientModel> tickets = body
            .map<BookingClientModel>(
                (jsonItem) => BookingClientModel.fromJson(jsonItem))
            .toList();

        return tickets;
      } else {
        throw Exception('Error');
      }
    } on TimeoutException catch (_) {
      throw Exception('Error');
    } on SocketException catch (_) {
      throw Exception('Error');
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
