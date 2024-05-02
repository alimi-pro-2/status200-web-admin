import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class DayTimeSeperater {
  List<String> dayTimeSeperater(Timestamp timestamp);
}
