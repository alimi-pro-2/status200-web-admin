import 'package:alimipro_mock_data/manage/presentation/view_model/notice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../data/data_source/notice_data_source.dart';
import '../data/repository/notice_respository_impl.dart';
import '../domain/repository/notice_repository.dart';

class FileUploadScreen extends StatefulWidget {
  final Map<String, String> academyInfo;
  FileUploadScreen({super.key, required this.academyInfo});

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  late NoticeViewModel noticeViewModel;

  @override
  void initState() {
    super.initState();

    //TODO: pastFromToday를 변수로 받아야 함. 오늘 부터 며칠 이전 까지의 기록을 받을 것 인지를 넘기는 곳
    Future.microtask(() {
       noticeViewModel = context.read<NoticeViewModel>();
    });
  }



  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;

      // Firebase Storage에 파일 업로드
      Reference storageRef =
          FirebaseStorage.instance.ref().child('uploads/${file.name}');
      UploadTask uploadTask = storageRef.putData(file.bytes!);
      TaskSnapshot snapshot = await uploadTask;

      // 업로드된 파일의 다운로드 URL 가져오기
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print(downloadUrl);
      // Firebase Firestore에 데이터 저장

      DocumentReference<Map<String, dynamic>> ts = await FirebaseFirestore.instance.collection('Notice').add({
        'academy': 'Academy Name', // 학원 이름
        'contents': 'Contents of the notice', // 공지 내용
        'date': Timestamp.now(), // 현재 시간을 Timestamp로 저장
        'parentsPhone': '01012345678', // 학부모 전화번호
        'pushType': 'Notification type', // 푸시 타입 (예: SMS, 앱 푸시 등)
        'title': 'Notice Title', // 공지 제목
        'fileUrl': downloadUrl, // 업로드된 파일의 다운로드 URL
      });



       await noticeViewModel.getNotice(ts.id);
       print(ts.id);
       print(noticeViewModel.notice.toString());

      // 파일 업로드 및 데이터 저장 완료
      print('File uploaded and notice added to Firestore!');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload File'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _uploadFile,
          child: const Text('Select File and Upload'),
        ),
      ),
    );
  }
}
