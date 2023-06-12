library globals;

import 'package:flutter/material.dart';

//ALTERAR PARA URL FINAL
String appName = "MobyDick";
String baseUrl = "http://localhost:8000";

//String baseUrl = "https://crm.mobydicktours.azornexus.com";
String datesLang = "pt_BR";
Duration timeoutDuration = Duration(seconds: 50);
int INTERNET_CONNECTION_ERROR = 500;
GlobalKey<ScaffoldState> key = GlobalKey();
