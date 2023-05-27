import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobydick/globals.dart' as globals;
import 'package:mobydick/models/stats_model.dart';

class StatsService {
  Future<Stats> getStats(String startDay, String endDay) async {
    try {
      final response = await http.get(
          Uri.parse(
              "${globals.baseUrl}/stats/?start_day=$startDay&end_day=$endDay"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 200) {
        Stats stats =
            Stats.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

        return stats;
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
