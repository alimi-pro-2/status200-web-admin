import 'package:alimipro_mock_data/admin/presentation/dto/academy_request_dto.dart';
import 'package:alimipro_mock_data/admin/presentation/view_model/academy_info_input_gate_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'country.dart';

class AcademyInfoInputGateScreen extends StatefulWidget {
  final AcademyInfoInputGateViewModel _viewModel;

  const AcademyInfoInputGateScreen({
    super.key,
    required AcademyInfoInputGateViewModel academyInfoInputGateViewModel,
  }) : _viewModel = academyInfoInputGateViewModel;

  @override
  State<AcademyInfoInputGateScreen> createState() =>
      _AcademyInfoInputGateScreenState();
}

class _AcademyInfoInputGateScreenState
    extends State<AcademyInfoInputGateScreen> {
  final _formController1 = TextEditingController();
  final _formController2 = TextEditingController();
  final _formController3 = TextEditingController();
  Country _dropdownValue = Country.korea;

  @override
  void dispose() {
    _formController1.dispose();
    _formController2.dispose();
    _formController3.dispose();
    super.dispose();
  }

  bool _validateName(TextEditingController controller) {
    final academyName = controller.text;
    if (academyName == null || academyName.isEmpty || academyName.trim().isEmpty) {
      return false;
    }
    return true;
  }

  bool _validateNumber() {
    final number = _formController3.text;
    bool isNumber = int.tryParse(number) == null ? false : true;
    if (number == null || number.isEmpty || number.length < 7 || !isNumber) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    'alimi.png',
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  const Text(
                    '국가',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  DropdownButton<Country>(
                    value: _dropdownValue,
                    items: Country.values.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      );
                    }).toList(),
                    onChanged: (Country? value) {
                      setState(() {
                        _dropdownValue = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _formController1,
                onChanged: (_) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _validateName(_formController1)
                          ? Colors.green
                          : Colors.black45,
                      width: 1.2,
                    ),
                  ),
                  labelText: '학원 이름',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _formController2,
                onChanged: (_) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _validateName(_formController2)
                          ? Colors.green
                          : Colors.black45,
                      width: 1.2,
                    ),
                  ),
                  labelText: '원장 이름 (출석체크기와 보호자 앱에 표시됩니다.)',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _formController3,
                onChanged: (_) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _validateNumber() ? Colors.green : Colors.black45,
                      width: 1.2,
                    ),
                  ),
                  labelText: '연락처 ( \'-\' 을 제외한 숫자만 입력하세요.)',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                child: const Text('확인'),
                onPressed: () async {
                  if (_validateName(_formController1) &&
                      _validateName(_formController2) &&
                      _validateNumber()) {
                    final academyRequestDto = AcademyRequestDto(
                      academyName: _formController1.text,
                      name: _formController2.text,
                      number: _formController3.text,
                    );
                    await widget._viewModel.postAcademyInfo(academyRequestDto);
                    context.go('/studentList');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
