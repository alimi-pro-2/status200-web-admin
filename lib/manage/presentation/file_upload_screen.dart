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
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  FilePickerResult? result;

  Future<void> _ficFile() async {
    result = await FilePicker.platform.pickFiles();
  }

  Future<void> _uploadFile(
      String title, String contents, String parentPhone) async {
    final noticeViewModel = context.read<NoticeViewModel>();
    String downloadUrl = '';

    if (result != null) {
      PlatformFile file = result!.files.first;

      // Firebase Storage에 파일 업로드
      Reference storageRef =
          FirebaseStorage.instance.ref().child('uploads/${file.name}');
      UploadTask uploadTask = storageRef.putData(file.bytes!);
      TaskSnapshot snapshot = await uploadTask;

      // 업로드된 파일의 다운로드 URL 가져오기
      downloadUrl = await snapshot.ref.getDownloadURL();

      Map<String, dynamic> noticeMap = {
        'academy': widget.academyInfo['name'], // 학원 이름
        'contents': contents, // 공지 내용
        'date': Timestamp.now(), // 현재 시간을 Timestamp로 저장
        'parentsPhone': parentPhone, // 학부모 전화번호
        'pushType': 'notice', // 푸시 타입 (예: SMS, 앱 푸시 등)
        'title': title, // 공지 제목
        'fileUrl': downloadUrl, // 업로드된 파일의 다운로드 URL
      };

      print(downloadUrl);
      // Firebase Firestore에 데이터 저장

      // DocumentReference<Map<String, dynamic>> ts = await FirebaseFirestore.instance.collection('Notice').add({
      //   'academy': 'Academy Name', // 학원 이름
      //   'contents': 'Contents of the notice', // 공지 내용
      //   'date': Timestamp.now(), // 현재 시간을 Timestamp로 저장
      //   'parentsPhone': '01012345678', // 학부모 전화번호
      //   'pushType': 'Notification type', // 푸시 타입 (예: SMS, 앱 푸시 등)
      //   'title': 'Notice Title', // 공지 제목
      //   'fileUrl': downloadUrl, // 업로드된 파일의 다운로드 URL
      // });

      String id = await noticeViewModel.setNotice(noticeMap);
      await noticeViewModel.getNotice(id);
      print(id);
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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: _controller1,
              decoration: const InputDecoration(labelText: '제목'),
            ),
            TextField(
              controller: _controller2,
              decoration: const InputDecoration(labelText: '내용'),
            ),
            TextField(
              controller: _controller3,
              decoration: const InputDecoration(labelText: '부모전화번호'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _ficFile, child: const Text('파일 선택')),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                String title = _controller1.text;
                String contents = _controller2.text;
                String parentsPhone = _controller3.text;
                await _uploadFile(title, contents, parentsPhone);
                Navigator.pop(context);
                // print('Input 1: $input1');
                // print('Input 2: $input2');
                // print('Input 3: $input3');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
