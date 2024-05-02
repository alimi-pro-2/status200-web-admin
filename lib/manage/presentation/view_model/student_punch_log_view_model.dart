import 'package:alimipro_mock_data/core/result/result.dart';
import 'package:alimipro_mock_data/manage/domain/model/personal_punch_log.dart';
import 'package:alimipro_mock_data/manage/domain/use_case/get_personal_punchlogs_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StudentPunchLogViewModel with ChangeNotifier {
  List<PersonalPunchLog> _punchLogs = [];
  final GetPersonalPunchLogsUseCase _personalPunchLogsUseCase;
  bool _hasError = false;
  bool isLoading = false;

  List<PersonalPunchLog> get punchLogs => List.unmodifiable(_punchLogs);
  bool get hasError => _hasError;

  Future<void> setPunchLogs({
    required String name,
    required String parentPhone,
    required int pastFromToday,
  }) async {
    isLoading = true;
    notifyListeners();

    final result = await _personalPunchLogsUseCase.getPersonalPunchLogs(
        name, parentPhone, pastFromToday);

    switch (result) {
      case Success<List<PersonalPunchLog>, String>():
        _hasError = false;
        _punchLogs = result.data.toList();
      case Error<List<PersonalPunchLog>, String>():
        _punchLogs = [];
        _hasError = true;
    }
    isLoading = false;
    notifyListeners();
  }

  StudentPunchLogViewModel({
    required GetPersonalPunchLogsUseCase personalPunchLogsUseCase,
  }) : _personalPunchLogsUseCase = personalPunchLogsUseCase;
}
