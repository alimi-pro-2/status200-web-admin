import 'package:cloud_firestore/cloud_firestore.dart';

extension DayTimeSeperator on Timestamp {
  List<String> dayTimeSeparator() {
    int dayStartNum = 0;
    int dayEndNum = 10;
    int timeStartNum = 11;
    int timeEndNum = 22;
    List<String> dateTimes = [];

    DateTime dateTime = toDate();
    dateTimes.add(dateTime.toString().substring(dayStartNum, dayEndNum));
    dateTimes.add(dateTime.toString().substring(timeStartNum, timeEndNum));
    return dateTimes;
  }
}
