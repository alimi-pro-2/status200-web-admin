import 'package:alimipro_mock_data/manage/domain/model/personal_punch_log.dart';
import 'package:alimipro_mock_data/manage/domain/use_case/get_personal_punchlogs_use_case.dart';
import 'package:flutter/material.dart';

class StudentPunchLogViewModel with ChangeNotifier {
  List<PersonalPunchLog> _punchLogs = [];
  final GetPersonalPunchLogsUseCase _personalPunchLogsUseCase;

  List<PersonalPunchLog> get punchLogs => List.unmodifiable(_punchLogs);

  Future<void> setPunchLogs({
    required String name,
    required String parentPhone,
    required int pastFromToday,
  }) async {
    _punchLogs = await _personalPunchLogsUseCase.getPersonalPunchLogs(
        name, parentPhone, pastFromToday);
    notifyListeners();
  }

  StudentPunchLogViewModel({
    required GetPersonalPunchLogsUseCase personalPunchLogsUseCase,
  }) : _personalPunchLogsUseCase = personalPunchLogsUseCase;
}
