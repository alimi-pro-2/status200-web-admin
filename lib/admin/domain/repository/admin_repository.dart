import 'package:alimipro_mock_data/admin/presentation/dto/academy_request_dto.dart';

abstract interface class AdminRepository {

  void postAcademyInfo(AcademyRequestDto academyRequestDto);
}