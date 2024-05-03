import 'package:alimipro_mock_data/admin/domain/use_case/post_academy_info_use_case.dart';
import 'package:alimipro_mock_data/admin/presentation/dto/academy_request_dto.dart';

class AcademyInfoInputGateViewModel {
  final PostAcademyInfoUseCase _postAcademyInfoUseCase;

  AcademyInfoInputGateViewModel({
    required PostAcademyInfoUseCase postAcademyInfoUseCase,
  }) : _postAcademyInfoUseCase = postAcademyInfoUseCase;

  void postAcademyInfo(AcademyRequestDto academyRequestDto) {
    _postAcademyInfoUseCase.postAcademyInfo(academyRequestDto);
  }
}
