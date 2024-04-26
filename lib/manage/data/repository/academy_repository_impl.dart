import 'package:alimipro_mock_data/manage/domain/model/academy.dart';
import 'package:alimipro_mock_data/manage/domain/model/personal_punch_log.dart';
import 'package:alimipro_mock_data/manage/domain/model/student.dart';
import 'package:alimipro_mock_data/manage/domain/repository/academy_repository.dart';

import '../data_source/academy_data_source.dart';
import '../data_source/log_data_source.dart';

class FirebaseAcademyRepositoryImpl implements AcademyRepository {
  final AcademyDataSource _academyDataSource;

  @override
  Future<Academy> getAcademy(String uid) async {
    final documentRef = _academyDataSource.getAcademyDocumentRef(uid);
    final documentSnapshot = await documentRef.get();

    

  }

  @override
  Future<List<Student>> getStudents(String uid) async {
    return  await _academyDataSource.getStudents(uid);
  }

  const FirebaseAcademyRepositoryImpl({
    required AcademyDataSource academyDataSource,
  }) : _academyDataSource = academyDataSource;
}
