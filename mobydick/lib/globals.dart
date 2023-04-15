library globals;

import 'package:flutter/material.dart';

//ALTERAR PARA URL FINAL
String appName = "MobyDick";
String baseUrl = "http://localhost:8000";

//String baseUrl = "https://3cce-5-148-108-178.eu.ngrok.io";
String dateLang = "pt_BR";
Duration timeoutDuration = Duration(seconds: 50);
int INTERNET_CONNECTION_ERROR = 500;
GlobalKey<ScaffoldState> key = GlobalKey();
