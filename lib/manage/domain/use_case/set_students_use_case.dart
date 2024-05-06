import 'package:injectable/injectable.dart';

import '../model/notice.dart';
import '../repository/notice_repository.dart';

@singleton
class SetNoticeUseCase {
  final NoticeRepository _noticeRepository;

  const SetNoticeUseCase({
    required NoticeRepository noticeRepository,
  }) : _noticeRepository = noticeRepository;

  Future<String> setNotice(Map<String, dynamic> noticeMap) async {
    Notice notice = Notice.fromJson(noticeMap);
    return await _noticeRepository.setNotice(notice);
  }
}
