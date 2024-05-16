import 'package:alimipro_mock_data/manage/domain/model/academy.dart';
import 'package:alimipro_mock_data/manage/domain/model/student.dart';
import 'package:alimipro_mock_data/manage/domain/use_case/get_academy_use_case.dart';
import 'package:alimipro_mock_data/manage/domain/use_case/get_students_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../data/utility/csv_maker_impl.dart';
import '../../data/utility/excel_maker_impl.dart';
import '../../data/utility/file_doenloader_impl.dart';
import '../../domain/utility/file_downloader.dart';
import '../../domain/utility/file_maker.dart';

@injectable
class AcademyStudentListViewModel with ChangeNotifier {
  Academy _academy = Academy(
    countryCode: '',
    createdTime: DateTime.now(),
    master: '',
    name: '',
    phone: '',
  );
  List<Student> _students = [];
  final GetAcademyUseCase _academyUseCase;
  final GetStudentsUseCase _studentsUseCase;

  Academy get academy => _academy;

  FileMaker excelMaker = ExcelMakerImpl();
  FileDownloader fileDownload = FileDownloaderImpl();
  FileMaker csvMaker = CsvMakerImpl();


  List<Student> get students => List.unmodifiable(_students);

  Future<void> setAcademy(String uid) async {
    final academy = await _academyUseCase.execute(uid);
    _academy = academy;
    notifyListeners();
  }

  Future<void> setStudents(String uid) async {
    final students = await _studentsUseCase.execute(uid);
    _students = students;
    notifyListeners();
  }

  void sortStudents(bool isNameAscending) {
    if (isNameAscending) {
      _students.sort((a, b) => a.name.compareTo(b.name));
    } else {
      _students.sort((a, b) => b.name.compareTo(a.name));
    }
    notifyListeners();
  }

  Future<void> csvDownload() async{

    final List<String> columnTitles = [
      '이름',
      '출결코드',
      '대표 보호자 번호',
      '메모',
    ];
    final String fileName = '${_academy.name} 학생명단.csv';

    final param =
    _students.map((e) => e.toJson()).toList();

    final List<String> columnContentsNames = [
      'name',
      'PIN',
      'parentsPhone1',
      'memo',
    ];
    final csvdata = await csvMaker.fileMaker(
      downloadContents: param,
      columnTitles: columnTitles,
      columnContentsNames: columnContentsNames,
      dayTimeSeparator: true,
    );
    await fileDownload.fileDownload(
        data: csvdata, fileName: fileName);
  }

  Future<void> excelDownload() async{
    final List<String> columnTitles = [
      '이름',
      '출결코드',
      '대표 보호자 번호',
      '메모',
    ];
    final String fileName = '${_academy.name} 학생명단.xlsx';

    final downloadContents =
    _students.map((e) => e.toJson()).toList();

    final List<String> columnContentsNames = [
      'name',
      'PIN',
      'parentsPhone1',
      'memo',
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






  AcademyStudentListViewModel({
    required GetAcademyUseCase academyUseCase,
    required GetStudentsUseCase studentsUseCase,
  })  : _academyUseCase = academyUseCase,
        _studentsUseCase = studentsUseCase;
}
