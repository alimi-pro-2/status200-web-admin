import 'package:alimipro_mock_data/manage/domain/model/academy.dart';
import 'package:alimipro_mock_data/manage/domain/model/student.dart';
import 'package:alimipro_mock_data/manage/domain/repository/academy_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetStudentsUseCase {
  final AcademyRepository _academyRepository;

  const GetStudentsUseCase({
    required AcademyRepository academyRepository,
  }) : _academyRepository = academyRepository;

  Future<List<Student>> getStudents(String uid) async {
    return await _academyRepository.getStudents(uid);
  }
}
