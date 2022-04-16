import 'package:intl/intl.dart';

String? uid;

String getDateTomorrow() {
  DateTime dateTime = DateTime.now().add(Duration(days: 1));
  String date = DateFormat.yMMMd().format(dateTime);
  return date;
}

//dynamic token ='';