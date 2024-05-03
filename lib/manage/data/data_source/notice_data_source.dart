import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
class NoticeDataSource {
  final FirebaseFirestore _firebaseFireStore;

  NoticeDataSource({required FirebaseFirestore firebaseFireStore})
      : _firebaseFireStore = firebaseFireStore;

  DocumentReference<Map<String, dynamic>> getNoticeDocumentRef(String uid) {
    final documentRef = _firebaseFireStore.collection('Notice').doc(uid);

    return documentRef;
  }
}