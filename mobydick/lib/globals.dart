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

int mobileWith = 700;
String email = "";
String name = "";
Uri url = Uri.parse(
    'https://crm.mobydicktours.azornexus.com/static/Ficha_MobyDick-Tours.png');
