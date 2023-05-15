import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobydick/globals.dart' as globals;
import 'package:mobydick/models/ticket_model.dart';

class TicketService {
  Future<List<Ticket>> searchTickets(String searchTerm) async {
    try {
      final response = await http.get(
        Uri.parse("${globals.baseUrl}/search/$searchTerm"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        List<Ticket> tickets =
            body.map<Ticket>((jsonItem) => Ticket.fromJson(jsonItem)).toList();

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

  Future<Ticket> getTicket(String ref) async {
    try {
      final response = await http.get(
        Uri.parse("${globals.baseUrl}ticket/get/$ref"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        Ticket ticket =
            Ticket.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

        return ticket;
      } else {
        throw Exception('Error');
      }
    } on TimeoutException catch (_) {
      throw Exception('Error');
    } on SocketException catch (_) {
      throw Exception('Error');
    }
  }
}
