import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/utility/csv_maker.dart';
import 'package:csv/csv.dart' as csv;

import '../../domain/utility/day_time_seperater.dart';
import 'day_time_seperater_impl.dart';

class CsvMakerImpl implements CsvMaker {
  @override
  Future<String> csvMaker({
    required List<Map<String, dynamic>> downloadcontents,
    required List<String> columnTitles,
    required List<String> columnContentsNames,
    bool dateTimeSperate = false,
  }) async {
    List<List<dynamic>> csvDatas = [columnTitles];
    DayTimeSeperater dayTimeSeperater = DayTimeSeperaterImpl();

    for (int row = 0; row < downloadcontents.length; row++) {
      Map<String, dynamic> downloadcontent = downloadcontents[row];
      List<dynamic> csvData = [];
      columnContentsNames.map((e) {
        if (downloadcontent[e] is Timestamp && dateTimeSperate) {
          final dayTimeSpe = dayTimeSeperater.dayTimeSeperater(downloadcontent[e]);
          csvData.add((dayTimeSpe[0]));
          csvData.add((dayTimeSpe[1]));
        } else {
          csvData.add(downloadcontent[e].toString());
        }
      }).toList();

      csvDatas.add(csvData);
    }

    String csvString = const csv.ListToCsvConverter().convert(csvDatas);
    return csvString;
  }
}
