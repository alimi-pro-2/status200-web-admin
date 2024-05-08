import 'package:alimipro_mock_data/admin/data/data_source/admin_data_source.dart';
import 'package:alimipro_mock_data/admin/domain/repository/admin_repository.dart';
import 'package:alimipro_mock_data/admin/presentation/dto/academy_request_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminDataSource _adminDataSource;

  const AdminRepositoryImpl({
    required AdminDataSource adminDataSource,
  }) : _adminDataSource = adminDataSource;

  @override
  Future<void> postAcademyInfo(AcademyRequestDto academyRequestDto) async {
    final data = {
      'name': academyRequestDto.academyName,
      'master': academyRequestDto.masterName,
      'phone': academyRequestDto.phoneNumber,
      'countryCode': academyRequestDto.countryNumber,
      'createdTime': academyRequestDto.createdTime,
    };
    await _adminDataSource.postAcademyInfo(data);
  }

  @override
  Future<bool> isRequiredInfoComplete() async {
    DocumentSnapshot<Map<String, dynamic>> academyInfo = await _adminDataSource.getAcademyInfo();
    String? name = academyInfo.data()?['name'];
    if (name == null || name.isEmpty) {
      return false;
    }
    return true;
  }
}
