import 'package:cloud_firestore_platform_interface/src/timestamp.dart';

import '../../domain/utility/day_time_seperater.dart';

class DayTimeSeperaterImpl implements DayTimeSeperater{
  @override
  List<String> dayTimeSeperater(Timestamp timestamp) {
    int dayStartNum =0;
    int dayEndNum =10;
    int timeStartNum =11;
    int timeEndNum =22;
    List<String> DateTimes = [];

    DateTime dateTime = timestamp.toDate();
    DateTimes.add(dateTime.toString().substring(dayStartNum, dayEndNum));
    DateTimes.add(dateTime.toString().substring(timeStartNum, timeEndNum));
    return  DateTimes;
  }

}