import 'package:alimipro_mock_data/manage/domain/model/personal_punch_log.dart';
import 'package:alimipro_mock_data/manage/domain/repository/log_data_repository.dart';

import '../../../core/result/result.dart';

class GetPersonalPunchLogsUseCase {
  final LogDataRepository _logDataRepository;

  Future<Result<List<PersonalPunchLog>, String>> getPersonalPunchLogs(
    String name,
    String parentPhone,
    int pastFromToday,
  ) async {
    try {
      final punchLogs = await _logDataRepository.getStudentsPunchLogs(
          name, parentPhone, pastFromToday);

      if (punchLogs.isEmpty) {
        return const Result.error('No punch logs found');
      } else {
        return Result.success(punchLogs);
      }
    } catch (e) {
      return Result.error('Failed to load punch logs $e');
    }
  }

  const GetPersonalPunchLogsUseCase({
    required LogDataRepository logDataRepository,
  }) : _logDataRepository = logDataRepository;
}
