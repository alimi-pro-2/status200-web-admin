import 'package:excel/excel.dart';

abstract interface class ExcelFileDownload {
  Future<void> excelFileDownload({
    required Excel excel,
    required String fileName,
  });
}
