import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';

import 'dart:html' as html;

import '../../domain/utility/excel_file_download.dart';

class WebExcelFileDownloadImpl implements ExcelFileDownload {
  Future<void> excelFileDownload({
    required Excel excel,
    required String fileName,
  }) async {
    fileName = '$fileName.xlsx';
    final List<int>? file = await excel.encode();
    final Uint8List? bytes = file != null ? Uint8List.fromList(file) : null;
    final blob = html.Blob([Uint8List.fromList(bytes!)]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
