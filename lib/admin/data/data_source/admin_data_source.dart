import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminDataSource {

  Future<void> postAcademyInfo(Map<String, String> data) async {
    final String _uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('Academies').doc(_uid).set(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getAcademyInfo() async {
    final String _uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('Academies').doc(_uid).get();
  }
}
