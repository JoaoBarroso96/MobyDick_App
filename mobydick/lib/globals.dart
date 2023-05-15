library globals;

import 'package:flutter/material.dart';

//ALTERAR PARA URL FINAL
String appName = "MobyDick";
String baseUrl = "http://localhost:8000";

//String baseUrl = "http://8a1b-2001-8a0-6094-8a01-7557-2292-154b-a6da.ngrok.io";
String dateLang = "pt_BR";
Duration timeoutDuration = Duration(seconds: 50);
int INTERNET_CONNECTION_ERROR = 500;
GlobalKey<ScaffoldState> key = GlobalKey();
