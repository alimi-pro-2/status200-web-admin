import 'package:alimipro_mock_data/manage/domain/model/personal_punch_log.dart';

abstract interface class LogDataRepository {
  Future<List<PersonalPunchLog>> getStudentsPunchLogs(
      String name, String parentPhone, int pastFromToday);
}
