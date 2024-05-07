import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';

import '../../domain/utility/day_time_seperater.dart';
import '../../domain/utility/excel_maker.dart';
import 'day_time_seperater_impl.dart';

class ExcelMakerImpl implements ExcelMaker {
  @override
  Future<Uint8List> excelMaker(
      {required List<Map<String, dynamic>> downloadcontents,
      required List<String> columnTitles,
      required List<String> columnContentsNames,
      bool dateTimeSperate = false}) async {
    Excel excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];
    DayTimeSeperater dayTimeSeperater = DayTimeSeperaterImpl();

    for (int i = 0; i < columnTitles.length; i++) {
      var cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(columnTitles[i]);
    }

    for (int row = 0; row < downloadcontents.length; row++) {
      final Map<String, dynamic> data = downloadcontents[row];

      List<dynamic> rowData = [];

      columnContentsNames.map((e) {
        if (data[e] is Timestamp && dateTimeSperate) {
          final dayTimeSpe = dayTimeSeperater.dayTimeSeperater(data[e]);
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
    return Uint8List.fromList(excel.encode()!);;
  }
}
