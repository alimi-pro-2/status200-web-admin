import 'package:cloud_firestore/cloud_firestore.dart';

class AcademyDataSource {
  final FirebaseFirestore _firebaseFireStore;

  AcademyDataSource({required FirebaseFirestore firebaseFireStore})
      : _firebaseFireStore = firebaseFireStore;

  DocumentReference<Map<String, dynamic>> getAcademyDocumentRef(String uid) {
    final documentRef = _firebaseFireStore.collection('Academies').doc(uid);

    return documentRef;
  }
}
