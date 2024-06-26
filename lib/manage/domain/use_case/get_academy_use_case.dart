import 'package:alimipro_mock_data/manage/domain/model/academy.dart';
import 'package:alimipro_mock_data/manage/domain/repository/academy_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetAcademyUseCase {
  final AcademyRepository _academyRepository;

  const GetAcademyUseCase({
    required AcademyRepository academyRepository,
  }) : _academyRepository = academyRepository;

  Future<Academy> execute(String uid) async {
    return await _academyRepository.getAcademy(uid);
  }
}
