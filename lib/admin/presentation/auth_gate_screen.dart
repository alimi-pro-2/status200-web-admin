import 'package:alimipro_mock_data/admin/presentation/component/icon_and_description.dart';
import 'package:alimipro_mock_data/admin/presentation/view_model/auth_gate_view_model.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthGateScreen extends StatelessWidget {
  final AuthGateViewModel _viewModel;

  const AuthGateScreen(
      {super.key, required AuthGateViewModel authGateViewModel,})
      : _viewModel = authGateViewModel;

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [EmailAuthProvider()],
      actions: [
        ForgotPasswordAction(((context, email) {
          final uri = Uri(
            path: '/sign-in/forgot-password',
            queryParameters: <String, String?>{
              'email': email,
            },
          );
          context.push(uri.toString());
        })),
        AuthStateChangeAction(((context, state) async {
          final user = switch (state) {
            SignedIn state => state.user,
            UserCreated state => state.credential.user,
            _ => null
          };
          if (user == null) {
            return;
          } else if (state is UserCreated) {
            context.go('/academy-info-input');
          } else if (state is SignedIn) {
            if (await _viewModel.isRequiredInfoComplete()) {
              context.go('/studentList', extra: user);
            } else {
              context.go('/academy-info-input');
            }
          }
        })),
      ],
      headerBuilder: (context, constraints, shrinkOffset) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset('assets/alimi_text.png'),
          ),
        );
      },
      subtitleBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: action == AuthAction.signIn
              ? const Text('당신의 아이는 지금 안전합니까? 등하원 알림 서비스로 아이를 지켜주세요.')
              : const Text('알리미프로는 원장님이 가입하는 서비스입니다. 원생의 보호자님은 가입할 필요가 없습니다.'),
        );
      },
      footerBuilder: (context, action) {
        return const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'Copyright © 2018 GeumWang Corporation.',
            style: TextStyle(color: Colors.grey),
          ),
        );
      },
      sideBuilder: (context, shrinkOffset) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 140,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    'alimi.png',
                  ),
                ),
              ),
              const IconAndDescription(
                icon: Icons.timeline,
                iconColor: Colors.red,
                header: '10일 무료 체험',
                detail: '계정 생성 시 10일간 체험 기간을 제공합니다.',
              ),
              const IconAndDescription(
                icon: Icons.assignment_ind,
                iconColor: Colors.blue,
                header: '관리 기능',
                detail: '원생 정보를 한 번에 확인하고 검색을 쉽게 할 수 있어 간단한 원생 관리용으로도 사용할 수 있습니다.',
              ),
              const IconAndDescription(
                icon: Icons.group,
                iconColor: Colors.indigo,
                header: '쉬운 원생 등록',
                detail: '원생 등록이 간단합니다. 원생 등록 후 보호자용 앱에서 바로 등원/하원 확인이 가능합니다.',
              ),
            ],
          ),
        );
      },
    );
  }
}
