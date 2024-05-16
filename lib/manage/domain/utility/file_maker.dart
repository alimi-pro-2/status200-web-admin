import 'dart:typed_data';


abstract interface class FileMaker {
  Future<Uint8List> fileMaker({
    required List<Map<String, dynamic>> downloadContents,
    required List<String> columnTitles,
    required List<String> columnContentsNames,
    bool dayTimeSeparator = false,
  });
}
