import 'package:alimipro_mock_data/admin/presentation/auth_gate_screen.dart';
import 'package:alimipro_mock_data/manage/presentation/academy_student_list_screen.dart';
import 'package:alimipro_mock_data/manage/presentation/student_punch_log_screen.dart';
import 'package:alimipro_mock_data/manage/presentation/view_model/academy_student_list_view_model.dart';
import 'package:alimipro_mock_data/manage/presentation/view_model/student_punch_log_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../di/di_setup.dart';

final router = GoRouter(
  initialLocation: '/sign-in',
  routes: [
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => const AuthGateScreen(),
      routes: [
        GoRoute(
          path: 'forgot-password',
          builder: (context, state) {
            final arguments = state.uri.queryParameters;
            return ForgotPasswordScreen(
              email: arguments['email'],
              headerMaxExtent: 200,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/studentList',
      builder: (context, state) {
        final data = state.extra as User;
        return ChangeNotifierProvider(
          create: (context) {
            return getIt<AcademyStudentListViewModel>();
          },
          child: AcademyStudentListScreen(user: data),
        );
      },
    ),
    GoRoute(
      path: '/studentList/punchLogs',
      builder: (context, state) {
        final data = state.extra as Map<String, String>;

        return ChangeNotifierProvider(
          create: (context) {
            return getIt<StudentPunchLogViewModel>();
          },
          child: StudentPunchLogScreen(
            studentInfo: data,
          ),
        );
      },
    ),
  ],
);
