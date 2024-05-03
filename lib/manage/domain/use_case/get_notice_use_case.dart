import 'package:injectable/injectable.dart';

import '../model/notice.dart';
import '../repository/notice_repository.dart';

@singleton
class GetNoticeUseCase {
  final NoticeRepository _noticeRepository;

  const GetNoticeUseCase({
    required NoticeRepository noticeRepository,
  }) : _noticeRepository = noticeRepository;

  Future<Notice> getNotice(String uid) async {
    return await _noticeRepository.getNotice(uid);
  }
}