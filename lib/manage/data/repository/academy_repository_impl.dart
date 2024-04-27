import 'package:alimipro_mock_data/manage/domain/model/academy.dart';
import 'package:alimipro_mock_data/manage/domain/model/student.dart';
import 'package:alimipro_mock_data/manage/domain/repository/academy_repository.dart';

import '../data_source/academy_data_source.dart';

class AcademyRepositoryImpl implements AcademyRepository {
  final AcademyDataSource _academyDataSource;

  @override
  Future<Academy> getAcademy(String uid) async {
    final documentRef = _academyDataSource.getAcademyDocumentRef(uid);
    final documentSnapshot = await documentRef.get();

    if (!documentSnapshot.exists) {
      throw Exception('등록되지 않은 학원입니다.');
    }

    return Academy.fromJson(documentSnapshot.data()!);
  }

  @override
  Future<List<Student>> getStudents(String uid) async {
    final documentRef = _academyDataSource.getAcademyDocumentRef(uid);
    final studentsSnapshot = await documentRef.collection('Students').get();

    if (studentsSnapshot.docs.isEmpty) {
      throw Exception('등록되지 않은 학원입니다.');
    }

    return studentsSnapshot.docs
        .map((e) => Student.fromJson(e.data()))
        .toList();
  }

  const AcademyRepositoryImpl({
    required AcademyDataSource academyDataSource,
  }) : _academyDataSource = academyDataSource;
}
