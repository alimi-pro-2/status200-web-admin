// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:alimipro_mock_data/core/di/app_module.dart' as _i21;
import 'package:alimipro_mock_data/manage/data/data_source/academy_data_source.dart'
    as _i6;
import 'package:alimipro_mock_data/manage/data/data_source/log_data_source.dart'
    as _i5;
import 'package:alimipro_mock_data/manage/data/data_source/notice_data_source.dart'
    as _i4;
import 'package:alimipro_mock_data/manage/data/repository/academy_repository_impl.dart'
    as _i8;
import 'package:alimipro_mock_data/manage/data/repository/log_data_repository_impl.dart'
    as _i12;
import 'package:alimipro_mock_data/manage/data/repository/notice_respository_impl.dart'
    as _i10;
import 'package:alimipro_mock_data/manage/domain/repository/academy_repository.dart'
    as _i7;
import 'package:alimipro_mock_data/manage/domain/repository/log_data_repository.dart'
    as _i11;
import 'package:alimipro_mock_data/manage/domain/repository/notice_repository.dart'
    as _i9;
import 'package:alimipro_mock_data/manage/domain/use_case/get_academy_use_case.dart'
    as _i13;
import 'package:alimipro_mock_data/manage/domain/use_case/get_notice_use_case.dart'
    as _i16;
import 'package:alimipro_mock_data/manage/domain/use_case/get_personal_punchlogs_use_case.dart'
    as _i17;
import 'package:alimipro_mock_data/manage/domain/use_case/get_students_use_case.dart'
    as _i14;
import 'package:alimipro_mock_data/manage/domain/use_case/set_students_use_case.dart'
    as _i15;
import 'package:alimipro_mock_data/manage/presentation/view_model/academy_student_list_view_model.dart'
    as _i19;
import 'package:alimipro_mock_data/manage/presentation/view_model/notice_view_model.dart'
    as _i20;
import 'package:alimipro_mock_data/manage/presentation/view_model/student_punch_log_view_model.dart'
    as _i18;
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
    gh.singleton<_i4.NoticeDataSource>(() =>
        _i4.NoticeDataSource(firebaseFireStore: gh<_i3.FirebaseFirestore>()));
    gh.singleton<_i5.LogDataSource>(() =>
        _i5.LogDataSource(firebaseFireStore: gh<_i3.FirebaseFirestore>()));
    gh.singleton<_i6.AcademyDataSource>(() =>
        _i6.AcademyDataSource(firebaseFireStore: gh<_i3.FirebaseFirestore>()));
    gh.singleton<_i7.AcademyRepository>(() => _i8.AcademyRepositoryImpl(
        academyDataSource: gh<_i6.AcademyDataSource>()));
    gh.singleton<_i9.NoticeRepository>(() => _i10.NoticeRepositoryImpl(
        noticeDataSource: gh<_i4.NoticeDataSource>()));
    gh.singleton<_i11.LogDataRepository>(() =>
        _i12.LogDataRepositoryImpl(logDataSource: gh<_i5.LogDataSource>()));
    gh.singleton<_i13.GetAcademyUseCase>(() =>
        _i13.GetAcademyUseCase(academyRepository: gh<_i7.AcademyRepository>()));
    gh.singleton<_i14.GetStudentsUseCase>(() => _i14.GetStudentsUseCase(
        academyRepository: gh<_i7.AcademyRepository>()));
    gh.singleton<_i15.SetNoticeUseCase>(() =>
        _i15.SetNoticeUseCase(noticeRepository: gh<_i9.NoticeRepository>()));
    gh.singleton<_i16.GetNoticeUseCase>(() =>
        _i16.GetNoticeUseCase(noticeRepository: gh<_i9.NoticeRepository>()));
    gh.singleton<_i17.GetPersonalPunchLogsUseCase>(() =>
        _i17.GetPersonalPunchLogsUseCase(
            logDataRepository: gh<_i11.LogDataRepository>()));
    gh.factory<_i18.StudentPunchLogViewModel>(() =>
        _i18.StudentPunchLogViewModel(
            personalPunchLogsUseCase: gh<_i17.GetPersonalPunchLogsUseCase>()));
    gh.factory<_i19.AcademyStudentListViewModel>(
        () => _i19.AcademyStudentListViewModel(
              academyUseCase: gh<_i13.GetAcademyUseCase>(),
              studentsUseCase: gh<_i14.GetStudentsUseCase>(),
            ));
    gh.factory<_i20.NoticeViewModel>(() => _i20.NoticeViewModel(
          setNoticeUseCase: gh<_i15.SetNoticeUseCase>(),
          noticeUseCase: gh<_i16.GetNoticeUseCase>(),
        ));
    return this;
  }
}

class _$AppModule extends _i21.AppModule {}
