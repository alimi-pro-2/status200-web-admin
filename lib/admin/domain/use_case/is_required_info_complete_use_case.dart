import 'package:alimipro_mock_data/admin/domain/repository/admin_repository.dart';

class IsRequiredInfoCompleteUseCase {

  final AdminRepository _adminRepository;

  const IsRequiredInfoCompleteUseCase({
    required AdminRepository adminRepository,
  }) : _adminRepository = adminRepository;

  Future<bool> execute() async {
    return await _adminRepository.isRequiredInfoComplete();
  }
}