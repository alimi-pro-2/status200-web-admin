abstract interface class CsvMaker {
  Future<String> csvMaker({
    required List<Map<String, dynamic>> downloadcontents,
    required List<String> columnTitles,
    required List<String> columnContentsNames,
    bool dateTimeSperate = false,
  });
}
