import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminDataSource {
  final User _user;

  const AdminDataSource({
    required User user,
  }) : _user = user;

  void postAcademyInfo(Map<String, String> data) {
    FirebaseFirestore.instance.collection('Academies').doc(_user.uid).set(data);
  }
}
