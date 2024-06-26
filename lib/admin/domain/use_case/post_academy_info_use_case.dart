import 'package:alimipro_mock_data/admin/domain/repository/admin_repository.dart';
import 'package:alimipro_mock_data/admin/presentation/dto/academy_request_dto.dart';

class PostAcademyInfoUseCase {
  final AdminRepository _adminRepository;

  PostAcademyInfoUseCase({
    required AdminRepository adminRepository,
  }) : _adminRepository = adminRepository;

  Future<void> execute(AcademyRequestDto academyRequestDto) async {
    return await _adminRepository.postAcademyInfo(academyRequestDto);
  }
}