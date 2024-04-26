import 'package:alimipro_mock_data/manage/domain/model/academy.dart';
import 'package:alimipro_mock_data/manage/domain/model/personal_punch_log.dart';
import 'package:alimipro_mock_data/manage/domain/model/student.dart';

// TODO: CRUD
abstract interface class AcademyRepository {

  Future<Academy> getAcademy(String uid);
  Future<List<Student>> getStudents(String uid);
}
