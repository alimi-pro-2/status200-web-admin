import 'package:alimipro_mock_data/admin/data/data_source/admin_data_source.dart';
import 'package:alimipro_mock_data/admin/data/repository/admin_repository_impl.dart';
import 'package:alimipro_mock_data/admin/domain/use_case/is_required_info_complete_use_case.dart';
import 'package:alimipro_mock_data/admin/domain/use_case/post_academy_info_use_case.dart';
import 'package:alimipro_mock_data/admin/presentation/academy_info_input_gate_screen.dart';
import 'package:alimipro_mock_data/admin/presentation/auth_gate_screen.dart';
import 'package:alimipro_mock_data/admin/presentation/view_model/academy_info_input_gate_view_model.dart';
import 'package:alimipro_mock_data/admin/presentation/view_model/auth_gate_view_model.dart';
import 'package:alimipro_mock_data/manage/presentation/academy_student_list_screen.dart';
import 'package:alimipro_mock_data/manage/presentation/student_punch_log_screen.dart';
import 'package:alimipro_mock_data/manage/presentation/view_model/academy_student_list_view_model.dart';
import 'package:alimipro_mock_data/manage/presentation/view_model/student_punch_log_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../manage/presentation/file_upload_screen.dart';
import '../../manage/presentation/view_model/notice_view_model.dart';
import '../di/di_setup.dart';

final router = GoRouter(
  initialLocation: '/sign-in',
  routes: [
    GoRoute(
      path: '/sign-in',
      builder: (context, state) {
        return AuthGateScreen(
          authGateViewModel: AuthGateViewModel(
            isRequiredInfoCompleteUseCase: IsRequiredInfoCompleteUseCase(
              adminRepository: AdminRepositoryImpl(
                adminDataSource: AdminDataSource(),
              ),
            ),
          ),
        );
      },
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
        path: '/academy-info-input',
        builder: (context, state) {
          return AcademyInfoInputGateScreen(
            academyInfoInputGateViewModel: AcademyInfoInputGateViewModel(
              postAcademyInfoUseCase: PostAcademyInfoUseCase(
                adminRepository: AdminRepositoryImpl(
                  adminDataSource: AdminDataSource(),
                ),
              ),
            ),
          );
        }),
    GoRoute(
      path: '/studentList',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (context) {
            return getIt<AcademyStudentListViewModel>();
          },
          child: AcademyStudentListScreen(),
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
    GoRoute(
      path: '/notice',
      builder: (context, state) {
        final data = state.extra as Map<String, String>;
        return ChangeNotifierProvider(
          create: (context) {
            return getIt<NoticeViewModel>();
          },
          child:  FileUploadScreen(academyInfo: data,
          ),
        );
      },
    ),
  ],
);
