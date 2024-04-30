import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import '../domain/model/personal_punch_log.dart';
import 'dart:html' as html;
import 'package:csv/csv.dart' as csv;

class ExcelDownload {
  Future<void> excelDownload(
    List<PersonalPunchLog> logs,
    String fileName,
    List<String> columnTitles,
  ) async {
    Excel excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    fileName = '$fileName.xlsx';

    for (int i = 0; i < columnTitles.length; i++) {
      var cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(columnTitles[i]);
    }

    for (int row = 0; row < logs.length; row++) {
      PersonalPunchLog e = logs[row];

      List<dynamic> rowData = [
        TextCellValue(e.name),
        TextCellValue(e.time.toString().substring(0, 10)),
        TextCellValue(e.time.toString().substring(11, 22)),
        TextCellValue(e.punchType)
      ];

      for (int col = 0; col < rowData.length; col++) {
        var cell = sheetObject.cell(
            CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row + 1));
        cell.value = rowData[col];
      }
    }

    final List<int>? file = await excel.encode();
    final Uint8List? bytes = file != null ? Uint8List.fromList(file) : null;
    if (kIsWeb) {
      final blob = html.Blob([Uint8List.fromList(bytes!)]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      //모바일용 코드만 남겨놈
      String directoryPath = '/storage/emulated/0/Download';
      Directory directory = Directory(directoryPath);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      String filePath = '$directoryPath/$fileName';
      File file = File(filePath);
      await file.writeAsBytes(excel.encode()!);
    }
  }

  Future<void> excelDownloadMapList(List<Map<String, dynamic>> logs,
      String fileName, List<String> columnTitles, List<String> haederName,
      {bool dateTimeSperate = false}) async {
    Excel excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    fileName = '$fileName.xlsx';

    for (int i = 0; i < columnTitles.length; i++) {
      var cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
      cell.value = TextCellValue(columnTitles[i]);
    }

    for (int row = 0; row < logs.length; row++) {
      final Map<String, dynamic> data = logs[row];

      List<dynamic> rowData = [];

      haederName.map((e) {
        if (data[e] is Timestamp && dateTimeSperate) {
          DateTime dateTime = data[e].toDate();
          rowData.add(TextCellValue(dateTime.toString().substring(0, 10)));
          rowData.add(TextCellValue(dateTime.toString().substring(11, 22)));
        } else {
          rowData.add(TextCellValue(data[e].toString()));
          print(data);
        }
      }).toList();

      for (int col = 0; col < rowData.length; col++) {
        var cell = sheetObject.cell(
            CellIndex.indexByColumnRow(columnIndex: col, rowIndex: row + 1));
        cell.value = rowData[col];
      }
    }

    final List<int>? file = await excel.encode();
    final Uint8List? bytes = file != null ? Uint8List.fromList(file) : null;
    if (kIsWeb) {
      final blob = html.Blob([Uint8List.fromList(bytes!)]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      //모바일용 코드만 남겨놈
      String directoryPath = '/storage/emulated/0/Download';
      Directory directory = Directory(directoryPath);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      String filePath = '$directoryPath/$fileName';
      File file = File(filePath);
      await file.writeAsBytes(excel.encode()!);
    }
  }

  Future<void> csvDownload(List<PersonalPunchLog> logs) async {
    String fileName = '등하원 내역.csv';

    List<List<dynamic>> csvData = [
      ['이름', '날짜', '시간', '등하원'],
      ...logs.map((e) => [
            e.name,
            e.time.toString().substring(0, 10),
            e.time.toString().substring(11, 22),
            e.punchType
          ]), // 기존 리스트 데이터 추가
    ];

    String csvString = const csv.ListToCsvConverter().convert(csvData);

    final blob = html.Blob([csvString], 'text/csv');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final link = html.AnchorElement(href: url)
      ..setAttribute('download', fileName);
    link.click();
    html.Url.revokeObjectUrl(url);
  }
}
