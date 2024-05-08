import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminDataSource {

  Future<void> postAcademyInfo(Map<String, dynamic> data) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('Academies').doc(uid).set(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getAcademyInfo() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    return await FirebaseFirestore.instance.collection('Academies').doc(uid).get();
  }
}
