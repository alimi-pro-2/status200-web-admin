import 'package:alimipro_mock_data/admin/domain/use_case/is_required_info_complete_use_case.dart';

class AuthGateViewModel {

  final IsRequiredInfoCompleteUseCase _isRequiredInfoCompleteUseCase;

  const AuthGateViewModel({
    required IsRequiredInfoCompleteUseCase isRequiredInfoCompleteUseCase,
  }) : _isRequiredInfoCompleteUseCase = isRequiredInfoCompleteUseCase;

  Future<bool> isRequiredInfoComplete() async {
    return await _isRequiredInfoCompleteUseCase.isRequiredInfoComplete();
  }
}