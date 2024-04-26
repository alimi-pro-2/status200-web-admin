import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/model/academy.dart';
import '../../domain/model/student.dart';

class AcademyDataSource {

  final FirebaseFirestore _firebaseFirestore;

  AcademyDataSource({required FirebaseFirestore firebaseFirestore}) : _firebaseFirestore = firebaseFirestore;


  Future<Academy> getAcademy(String uid) async {
    final snapshot = await _firebaseFirestore
        .collection('Academies')
        .doc(uid)
        .get();

    if (!snapshot.exists) {
      throw Exception('미등록 학원');
    }

    return Academy.fromJson(snapshot.data()!);
  }

  Future<List<Student>> getStudents(String uid) async {
    final snapshot = await _firebaseFirestore
        .collection('Academies')
        .doc(uid)
        .collection('Students')
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception('학생정보를 찾을 수 없습니다.');
    }

    return snapshot.docs.map((e) => Student.fromJson(e.data())).toList();
  }




}
