import 'dart:typed_data';

abstract interface class CsvMaker {
  Future<Uint8List> csvMaker({
    required List<Map<String, dynamic>> downloadcontents,
    required List<String> columnTitles,
    required List<String> columnContentsNames,
    bool dateTimeSperate = false,
  });
}
