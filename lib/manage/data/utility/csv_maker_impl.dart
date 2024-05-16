import 'dart:typed_data';

import 'package:alimipro_mock_data/manage/data/utility/day_time_seperater_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:csv/csv.dart' as csv;

import '../../domain/utility/file_maker.dart';

import 'dart:convert';

class CsvMakerImpl implements FileMaker {
  @override
  Future<Uint8List> fileMaker({
    required List<Map<String, dynamic>> downloadContents,
    required List<String> columnTitles,
    required List<String> columnContentsNames,
    bool dayTimeSeparator = false,
  }) async {
    List<List<dynamic>> csvDatas = [columnTitles];

    for (int row = 0; row < downloadContents.length; row++) {
      Map<String, dynamic> downloadcontent = downloadContents[row];
      List<dynamic> csvData = [];
      columnContentsNames.map((e) {
        if (downloadcontent[e] is Timestamp && dayTimeSeparator) {
          final dayTimeSpe = (downloadcontent[e] as Timestamp).dayTimeSeparator();
          csvData.add((dayTimeSpe[0]));
          csvData.add((dayTimeSpe[1]));
        } else {
          csvData.add(downloadcontent[e].toString());
        }
      }).toList();

      csvDatas.add(csvData);
    }

    String csvString = const csv.ListToCsvConverter().convert(csvDatas);
    return Uint8List.fromList(utf8.encode(csvString));
  }
}
