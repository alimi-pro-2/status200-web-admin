import 'package:alimipro_mock_data/manage/domain/model/academy.dart';
import 'package:alimipro_mock_data/manage/domain/repository/academy_repository.dart';

class GetAcademyUseCase {
  final AcademyRepository _academyRepository;

  const GetAcademyUseCase({
    required AcademyRepository academyRepository,
  }) : _academyRepository = academyRepository;

  Future<Academy> getAcademy(String uid) async {
    return await _academyRepository.getAcademy(uid);
  }
}
