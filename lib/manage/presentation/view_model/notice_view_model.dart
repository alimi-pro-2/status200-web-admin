import 'package:alimipro_mock_data/manage/domain/use_case/set_students_use_case.dart';
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
  final GetNoticeUseCase _getNoticeUseCase;
  final SetNoticeUseCase _setNoticeUseCase;

  Notice get notice => _notice;

  Future<void> getNotice(String uid) async {
    final notice = await _getNoticeUseCase.getNotice(uid);
    _notice = notice;
    notifyListeners();
  }

  Future<String> setNotice( Map<String, dynamic> noticeMap) async {
    final id = await _setNoticeUseCase.setNotice( noticeMap);
    notifyListeners();
    return id;
  }

  NoticeViewModel({
    required SetNoticeUseCase setNoticeUseCase,
    required GetNoticeUseCase noticeUseCase,
  })  : _getNoticeUseCase = noticeUseCase,
        _setNoticeUseCase = setNoticeUseCase;
}
