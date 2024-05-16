import 'package:alimipro_mock_data/core/result/result.dart';
import 'package:alimipro_mock_data/manage/domain/model/personal_punch_log.dart';
import 'package:alimipro_mock_data/manage/domain/use_case/get_personal_punchlogs_use_case.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../data/utility/csv_maker_impl.dart';
import '../../data/utility/excel_maker_impl.dart';
import '../../data/utility/file_doenloader_impl.dart';
import '../../domain/utility/file_downloader.dart';
import '../../domain/utility/file_maker.dart';

@injectable
class StudentPunchLogViewModel with ChangeNotifier {
  List<PersonalPunchLog> _punchLogs = [];
  final GetPersonalPunchLogsUseCase _personalPunchLogsUseCase;
  bool _hasError = false;
  bool isLoading = false;

  FileMaker excelMaker = ExcelMakerImpl();
  FileDownloader fileDownload = FileDownloaderImpl();
  FileMaker csvMaker = CsvMakerImpl();

  List<PersonalPunchLog> get punchLogs => List.unmodifiable(_punchLogs);
  bool get hasError => _hasError;

  Future<void> setPunchLogs({
    required String name,
    required String parentPhone,
    required int pastFromToday,
  }) async {
    isLoading = true;
    notifyListeners();

    final result = await _personalPunchLogsUseCase.execute(
        name, parentPhone, pastFromToday);

    switch (result) {
      case Success<List<PersonalPunchLog>, String>():
        _hasError = false;
        _punchLogs = result.data.toList();
      case Error<List<PersonalPunchLog>, String>():
        _punchLogs = [];
        _hasError = true;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> csvDownload() async{

    final List<String> columnTitles = [
      '이름',
      '날짜',
      '시간',
      '등하원'
    ];
    final String fileName =
        '${_punchLogs[0].name} 등하원내역.csv';

    final downloadContents = _punchLogs
        .map((e) => e.toJson())
        .toList();
    final List<String> columnContentsNames = [
      'name',
      'time',
      'punchType'
    ];

    final csvdata = await csvMaker.fileMaker(
      downloadContents: downloadContents,
      columnTitles: columnTitles,
      columnContentsNames: columnContentsNames,
      dayTimeSeparator: true,
    );
    await fileDownload.fileDownload(
      data: csvdata,
      fileName: fileName,
    );
  }

  Future<void> excelDownload() async{
    final List<String> columnTitles = [
      '이름',
      '날짜',
      '시간',
      '등하원'
    ];
    final String fileName =
        '${_punchLogs[0].name} 등하원내역.xlsx';

    final downloadContents = _punchLogs
        .map((e) => e.toJson())
        .toList();

    final List<String> columnContentsNames = [
      'name',
      'time',
      'punchType'
    ];
    final excelfile = await excelMaker.fileMaker(
      downloadContents: downloadContents,
      columnTitles: columnTitles,
      columnContentsNames: columnContentsNames,
      dayTimeSeparator: true,
    );
    await fileDownload.fileDownload(
      data: excelfile,
      fileName: fileName,
    );
  }

  StudentPunchLogViewModel({
    required GetPersonalPunchLogsUseCase personalPunchLogsUseCase,
  }) : _personalPunchLogsUseCase = personalPunchLogsUseCase;
}
