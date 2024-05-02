import 'dart:io';

import 'package:excel/excel.dart';

import '../../domain/utility/Excel_file_download.dart';

class MobileExcelFileDownload implements ExcelFileDownload {
  @override
  Future<void> excelFileDownload({
    required Excel excel,
    required String fileName,
  }) async {
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
