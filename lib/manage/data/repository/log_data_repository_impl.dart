import 'package:alimipro_mock_data/manage/data/data_source/log_data_source.dart';
import 'package:alimipro_mock_data/manage/domain/model/personal_punch_log.dart';
import 'package:alimipro_mock_data/manage/domain/repository/log_data_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogDataRepositoryImpl implements LogDataRepository {
  final LogDataSource _logDataSource;

  @override
  Future<List<PersonalPunchLog>> getStudentsPunchLogs(
    String name,
    String parentPhone,
    int pastFromToday,
  ) async {
    final String changeNumber = parentPhone.replaceRange(0, 1, '+82');
    final DateTime aMonthAgo =
        DateTime.now().subtract(Duration(days: pastFromToday));
    final punchLogRef = _logDataSource.getPunchLogCollectionRef();
    final querySnapshot = await punchLogRef.where('name', isEqualTo: name)
      .where('parentsPhone', isEqualTo: changeNumber)
      .where('time', isGreaterThan: Timestamp.fromDate(aMonthAgo))
      .orderBy('time', descending: true)
      .get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('등하원 기록이 없습니다.');
    }

    return querySnapshot.docs.map((e) => PersonalPunchLog.fromJson(e.data())).toList();
  }

  LogDataRepositoryImpl({
    required LogDataSource logDataSource,
  }) : _logDataSource = logDataSource;
}