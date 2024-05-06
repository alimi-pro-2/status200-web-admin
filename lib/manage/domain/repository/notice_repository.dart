import '../model/notice.dart';

abstract interface class NoticeRepository {

  Future<Notice> getNotice(String uid);
  Future<String> setNotice(Notice notice);
}
