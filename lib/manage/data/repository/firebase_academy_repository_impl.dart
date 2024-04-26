import 'package:alimipro_mock_data/manage/domain/model/academy.dart';
import 'package:alimipro_mock_data/manage/domain/model/personal_punch_log.dart';
import 'package:alimipro_mock_data/manage/domain/model/student.dart';
import 'package:alimipro_mock_data/manage/domain/repository/academy_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data_source/academy_data_source.dart';
import '../data_source/log_data_source.dart';

class FirebaseAcademyRepositoryImpl implements AcademyRepository {

  final AcademyDataSource _academyDataSource;
  final LogDataSource _logDataSource;

  FirebaseAcademyRepositoryImpl({required AcademyDataSource academyDataSource, required LogDataSource logDataSource}) : _academyDataSource = academyDataSource, _logDataSource = logDataSource;

  @override
  Future<Academy> getAcademy(String uid) async {
   return await _academyDataSource.getAcademy(uid);
  }

  @override
  Future<List<Student>> getStudents(String uid) async {
    return  await _academyDataSource.getStudents(uid);
  }

  @override
  Future<List<PersonalPunchLog>> getStudentPunchLogs(
      String name, String parentPhone) async {
    return  await _logDataSource.getStudentPunchLogs(name, parentPhone);
  }
}
