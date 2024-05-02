abstract interface class CsvFileDownload {
  Future<void> csvFileDownload({
    required String csvdata,
    required String fileName,
  });
}
