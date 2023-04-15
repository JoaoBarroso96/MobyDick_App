import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mobydick/globals.dart' as globals;
import 'package:mobydick/models/ticket_model.dart';
import 'package:mobydick/models/trip_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking_create_model.dart';

class UserService {
  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(Uri.parse("${globals.baseUrl}/login/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"username": username, "password": password}));
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
        print(body["token"]);
        if (!body["error"]) {
          final prefs = await SharedPreferences.getInstance();
          print(body["token"]);
          await prefs.setString('token', body["token"]);
          return true;
        }

        return false;
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
