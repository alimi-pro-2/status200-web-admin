import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';

import '../../domain/utility/file_maker.dart';
import 'day_time_seperator.dart';

class ExcelMakerImpl implements FileMaker {
  @override
  Future<Uint8List> fileMaker(
      {required List<Map<String, dynamic>> downloadContents,
      required List<String> columnTitles,
      required List<String> columnContentsNames,
      bool dayTimeSeparator = false}) async {
    Excel excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    for (int i = 0; i < columnTitles.length; i++) {
      var cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(columnTitles[i]);
    }

    for (int row = 0; row < downloadContents.length; row++) {
      final Map<String, dynamic> data = downloadContents[row];

      List<dynamic> rowData = [];

      columnContentsNames.map((e) {
        if (data[e] is Timestamp && dayTimeSeparator) {
          final dayTimeSpe = (data[e] as Timestamp).dayTimeSeparator();
          rowData.add(TextCellValue(dayTimeSpe[0]));
          rowData.add(TextCellValue(dayTimeSpe[1]));
        } else {
          rowData.add(TextCellValue(data[e].toString()));
        }
      }).toList();

      for (int col = 0; col < rowData.length; col++) {
        var cell = sheetObject.cell(
            CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row + 1));
        cell.value = rowData[col];
      }
    }
    return Uint8List.fromList(excel.encode()!);
  }
}
