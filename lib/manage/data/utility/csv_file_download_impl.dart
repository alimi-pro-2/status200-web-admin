import 'package:alimipro_mock_data/manage/domain/utility/csv_file_download.dart';
import 'dart:html' as html;

class WebCsvFileDownloadImpl implements CsvFileDownload {
  @override
  Future<void> csvFileDownload({required String csvdata, required String fileName}) async{
    final blob = html.Blob([csvdata], 'text/csv');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final link = html.AnchorElement(href: url)
      ..setAttribute('download', fileName);
    link.click();
    html.Url.revokeObjectUrl(url);
  }

}