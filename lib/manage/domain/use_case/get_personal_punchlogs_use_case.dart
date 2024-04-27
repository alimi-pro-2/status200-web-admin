import 'package:alimipro_mock_data/manage/domain/model/personal_punch_log.dart';
import 'package:alimipro_mock_data/manage/domain/repository/log_data_repository.dart';

class GetPersonalPunchLogsUseCase {
  final LogDataRepository _logDataRepository;

  Future<List<PersonalPunchLog>> getPersonalPunchLogs(
    String name,
    String parentPhone,
    int pastFromToday,
  ) async {
    final punchLogs = await _logDataRepository.getStudentsPunchLogs(
        name, parentPhone, pastFromToday);

    return punchLogs;
  }

  const GetPersonalPunchLogsUseCase({
    required LogDataRepository logDataRepository,
  }) : _logDataRepository = logDataRepository;
}
