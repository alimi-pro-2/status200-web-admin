import 'package:alimipro_mock_data/admin/data/data_source/admin_data_source.dart';
import 'package:alimipro_mock_data/admin/domain/repository/admin_repository.dart';
import 'package:alimipro_mock_data/admin/presentation/dto/academy_request_dto.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminDataSource _adminDataSource;

  const AdminRepositoryImpl({
    required AdminDataSource adminDataSource,
  }) : _adminDataSource = adminDataSource;

  @override
  void postAcademyInfo(AcademyRequestDto academyRequestDto) {
    final data = {
      'name': academyRequestDto.academyName,
      'master': academyRequestDto.name,
      'phone': academyRequestDto.number,
    };
    _adminDataSource.postAcademyInfo(data);
  }
}
