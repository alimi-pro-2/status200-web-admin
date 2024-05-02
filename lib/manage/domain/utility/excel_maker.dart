import 'package:excel/excel.dart';

abstract interface class ExcelMaker {
  Future<Excel> excelMaker({
    required List<Map<String, dynamic>> downloadcontents,
    required List<String> columnTitles,
    required List<String> columnContentsNames,
    bool dateTimeSperate = false,
  });
}
