import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
class LogDataSource {
  final FirebaseFirestore _firebaseFireStore;

  LogDataSource({required FirebaseFirestore firebaseFireStore})
      : _firebaseFireStore = firebaseFireStore;

  CollectionReference<Map<String, dynamic>> getPunchLogCollectionRef() {
    final punchLogsRef = _firebaseFireStore.collection('PunchLogs');

    return punchLogsRef;
  }
}
