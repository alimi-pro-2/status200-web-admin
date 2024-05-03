import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/notice.dart';
import '../../domain/use_case/get_notice_use_case.dart';

@injectable
class NoticeViewModel with ChangeNotifier {
  Notice _notice = Notice(
    academy: '',
    contents: '',
    parentsPhone: '',
    pushType: '',
    title: '',
    date: DateTime.now(),
  );
  final GetNoticeUseCase _noticeUseCase;

  Notice get notice => _notice;

  Future<void> setNotice(String uid) async {
    final notice = await _noticeUseCase.getNotice(uid);
    _notice = notice;
    notifyListeners();
  }

  NoticeViewModel({required GetNoticeUseCase noticeUseCase,}): _noticeUseCase = noticeUseCase;
}