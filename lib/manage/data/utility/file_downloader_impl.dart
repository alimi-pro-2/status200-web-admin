import 'dart:html' as html;
import 'dart:typed_data';

import 'package:alimipro_mock_data/manage/domain/utility/file_downloader.dart';

class FileDownloaderImpl implements Downloader {
  @override
  Future<void> download({
    required Uint8List data,
    required String fileName,
  }) async {
    final blob = html.Blob([data]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final link = html.AnchorElement(href: url)
      ..setAttribute('download', fileName);
    link.click();
    html.Url.revokeObjectUrl(url);
  }
}
