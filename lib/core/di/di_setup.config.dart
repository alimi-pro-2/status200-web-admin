// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:alimipro_mock_data/core/di/app_module.dart' as _i15;
import 'package:alimipro_mock_data/manage/data/data_source/academy_data_source.dart'
    as _i4;
import 'package:alimipro_mock_data/manage/data/data_source/log_data_source.dart'
    as _i5;
import 'package:alimipro_mock_data/manage/data/repository/academy_repository_impl.dart'
    as _i7;
import 'package:alimipro_mock_data/manage/data/repository/log_data_repository_impl.dart'
    as _i9;
import 'package:alimipro_mock_data/manage/domain/repository/academy_repository.dart'
    as _i6;
import 'package:alimipro_mock_data/manage/domain/repository/log_data_repository.dart'
    as _i8;
import 'package:alimipro_mock_data/manage/domain/use_case/get_academy_use_case.dart'
    as _i10;
import 'package:alimipro_mock_data/manage/domain/use_case/get_personal_punchlogs_use_case.dart'
    as _i12;
import 'package:alimipro_mock_data/manage/domain/use_case/get_students_use_case.dart'
    as _i11;
import 'package:alimipro_mock_data/manage/presentation/view_model/academy_student_list_view_model.dart'
    as _i14;
import 'package:alimipro_mock_data/manage/presentation/view_model/student_punch_log_view_model.dart'
    as _i13;
import 'package:cloud_firestore/cloud_firestore.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i3.FirebaseFirestore>(() => appModule.firebaseFirestore);
    gh.singleton<_i4.AcademyDataSource>(() =>
        _i4.AcademyDataSource(firebaseFireStore: gh<_i3.FirebaseFirestore>()));
    gh.singleton<_i5.LogDataSource>(() =>
        _i5.LogDataSource(firebaseFireStore: gh<_i3.FirebaseFirestore>()));
    gh.singleton<_i6.AcademyRepository>(() => _i7.AcademyRepositoryImpl(
        academyDataSource: gh<_i4.AcademyDataSource>()));
    gh.singleton<_i8.LogDataRepository>(() =>
        _i9.LogDataRepositoryImpl(logDataSource: gh<_i5.LogDataSource>()));
    gh.singleton<_i10.GetAcademyUseCase>(() =>
        _i10.GetAcademyUseCase(academyRepository: gh<_i6.AcademyRepository>()));
    gh.singleton<_i11.GetStudentsUseCase>(() => _i11.GetStudentsUseCase(
        academyRepository: gh<_i6.AcademyRepository>()));
    gh.singleton<_i12.GetPersonalPunchLogsUseCase>(() =>
        _i12.GetPersonalPunchLogsUseCase(
            logDataRepository: gh<_i8.LogDataRepository>()));
    gh.factory<_i13.StudentPunchLogViewModel>(() =>
        _i13.StudentPunchLogViewModel(
            personalPunchLogsUseCase: gh<_i12.GetPersonalPunchLogsUseCase>()));
    gh.factory<_i14.AcademyStudentListViewModel>(
        () => _i14.AcademyStudentListViewModel(
              academyUseCase: gh<_i10.GetAcademyUseCase>(),
              studentsUseCase: gh<_i11.GetStudentsUseCase>(),
            ));
    return this;
  }
}

class _$AppModule extends _i15.AppModule {}
