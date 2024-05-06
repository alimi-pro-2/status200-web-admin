import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/notice.dart';

@singleton
class NoticeDataSource {
  final FirebaseFirestore _firebaseFireStore;

  NoticeDataSource({required FirebaseFirestore firebaseFireStore})
      : _firebaseFireStore = firebaseFireStore;

  DocumentReference<Map<String, dynamic>> getNoticeDocumentRef(String uid) {
    final documentRef = _firebaseFireStore.collection('Notice').doc(uid);

    return documentRef;
  }

  Future<DocumentReference<Map<String, dynamic>>> setNoticeDocumentRef(Notice notice) async{
    DocumentReference<Map<String, dynamic>> result = await _firebaseFireStore.collection('Notice').add(notice.toJson());
/*    {
      'academy': 'Academy Name', // 학원 이름
    'contents': 'Contents of the notice', // 공지 내용
    'date': Timestamp.now(), // 현재 시간을 Timestamp로 저장
    'parentsPhone': '01012345678', // 학부모 전화번호
    'pushType': 'Notification type', // 푸시 타입 (예: SMS, 앱 푸시 등)
    'title': 'Notice Title', // 공지 제목
    'fileUrl': 'downloadUrl', // 업로드된 파일의 다운로드 URL
  }*/
    return result;
  }


}