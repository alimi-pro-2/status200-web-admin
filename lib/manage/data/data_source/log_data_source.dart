import 'package:cloud_firestore/cloud_firestore.dart';

class LogDataSource {
  final FirebaseFirestore _firebaseFireStore;

  LogDataSource({required FirebaseFirestore firebaseFireStore})
      : _firebaseFireStore = firebaseFireStore;

  CollectionReference<Map<String, dynamic>> getPunchLogCollectionRef() {
    final punchLogsRef = _firebaseFireStore.collection('PunchLogs');

    return punchLogsRef;
  }
}
