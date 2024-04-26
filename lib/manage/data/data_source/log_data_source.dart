import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/model/personal_punch_log.dart';


class LogDataSource{

  final FirebaseFirestore _firebaseFirestore;

  LogDataSource({required FirebaseFirestore firebaseFirestore}) : _firebaseFirestore = firebaseFirestore;

  Future<List<PersonalPunchLog>> getStudentPunchLogs(
      String name, String parentPhone) async {
    final String changeNumber = parentPhone.replaceRange(0, 1, '+82');
    final DateTime aMonthAgo =
    DateTime.now().subtract(const Duration(days: 1200));
    final snapshot = await _firebaseFirestore
        .collection('PunchLogs')
        .where('name', isEqualTo: name)
        .where('parentsPhone', isEqualTo: changeNumber)
        .where('time', isGreaterThan: Timestamp.fromDate(aMonthAgo))
        .orderBy('time', descending: true)
        .get();

    print(Timestamp.fromDate(aMonthAgo));
    print('데이터 렝스: ${snapshot.docs.length}');

    if (snapshot.docs.isEmpty) {
      throw Exception('데이터를 찾을 수 없습니다.');
    }
    final List<PersonalPunchLog> result =
    snapshot.docs.map((e) => PersonalPunchLog.fromJson(e.data())).toList();

    return result;
  }
}