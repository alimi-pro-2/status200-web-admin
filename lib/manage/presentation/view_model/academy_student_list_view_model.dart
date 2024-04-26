import 'package:alimipro_mock_data/manage/domain/model/academy.dart';
import 'package:alimipro_mock_data/manage/domain/model/student.dart';
import 'package:alimipro_mock_data/manage/domain/use_case/get_academy_use_case.dart';
import 'package:alimipro_mock_data/manage/domain/use_case/get_students_use_case.dart';
import 'package:flutter/cupertino.dart';

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

  List<Student> get students => List.unmodifiable(_students);

  Future<void> setAcademy(String uid) async {
    final academy = await _academyUseCase.getAcademy(uid);
    _academy = academy;
    notifyListeners();
  }
  Future<void> setStudents(String uid) async {
    final students = await _studentsUseCase.getStudents(uid);
    _students = students;
    notifyListeners();
  }

  AcademyStudentListViewModel({
    required GetAcademyUseCase academyUseCase,
    required GetStudentsUseCase studentsUseCase,
  })  : _academyUseCase = academyUseCase,
        _studentsUseCase = studentsUseCase;
}
