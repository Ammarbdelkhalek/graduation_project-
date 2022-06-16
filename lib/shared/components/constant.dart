import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String? uid;

String getDateTomorrow() {
  DateTime dateTime = DateTime.now().add(Duration(days: 1));
  String date = DateFormat.yMMMd().format(dateTime);
  return date;
}

//colors used in this app

const Color white = Colors.white;
const Color black = Colors.black;
const Color red = Colors.red;
const Color darkBlue = Color.fromRGBO(19, 26, 44, 1.0);

//default app padding

const double appPadding = 30.0;

String baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";

String mapkey = 'AIzaSyB8ouG6DHqKcBayUzndcNoI4AsRHm4xWS0';
