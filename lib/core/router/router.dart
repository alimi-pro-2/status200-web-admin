import 'package:alimipro_mock_data/manage/data/data_source/academy_data_source.dart';
import 'package:alimipro_mock_data/manage/data/data_source/log_data_source.dart';
import 'package:alimipro_mock_data/manage/data/repository/academy_repository_impl.dart';
import 'package:alimipro_mock_data/manage/data/repository/log_data_repository_impl.dart';
import 'package:alimipro_mock_data/manage/domain/repository/academy_repository.dart';
import 'package:alimipro_mock_data/manage/domain/repository/log_data_repository.dart';
import 'package:alimipro_mock_data/manage/domain/use_case/get_academy_use_case.dart';
import 'package:alimipro_mock_data/manage/domain/use_case/get_personal_punchlogs_use_case.dart';
import 'package:alimipro_mock_data/manage/domain/use_case/get_students_use_case.dart';
import 'package:alimipro_mock_data/manage/presentation/academy_student_list_screen.dart';
import 'package:alimipro_mock_data/manage/presentation/student_punch_log_screen.dart';
import 'package:alimipro_mock_data/manage/presentation/view_model/academy_student_list_view_model.dart';
import 'package:alimipro_mock_data/manage/presentation/view_model/student_punch_log_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

//TODO: db 전역변수를 어떻게 할것인지
//final db = FirebaseFirestore.instance..useFirestoreEmulator('10.0.2.2', 8080);
final db = FirebaseFirestore.instance..useFirestoreEmulator('localhost', 8080);

final router = GoRouter(
  initialLocation: '/studentList',
  routes: [
    GoRoute(
      path: '/studentList',
      builder: (context, state) {
        final AcademyRepository repo = AcademyRepositoryImpl(
            academyDataSource: AcademyDataSource(firebaseFireStore: db));
        return ChangeNotifierProvider(
          create: (context) {
            return AcademyStudentListViewModel(
                academyUseCase: GetAcademyUseCase(academyRepository: repo),
                studentsUseCase: GetStudentsUseCase(academyRepository: repo));
          },
          child: const AcademyStudentListScreen(),
        );
      },
    ),
    GoRoute(
      path: '/studentList/punchLogs',
      builder: (context, state) {
        final LogDataRepository repo = LogDataRepositoryImpl(
            logDataSource: LogDataSource(firebaseFireStore: db));
        final data = state.extra as Map<String, String>;

        return ChangeNotifierProvider(
          create: (context) {
            return StudentPunchLogViewModel(
                personalPunchLogsUseCase:
                    GetPersonalPunchLogsUseCase(logDataRepository: repo));
          },
          child: StudentPunchLogScreen(
            studentInfo: data,
          ),
        );
      },
    ),
  ],
);
