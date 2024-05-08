import 'package:alimipro_mock_data/manage/presentation/view_model/notice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'component/input_dialog.dart';
import 'component/size_exceed_dialog.dart';
import 'component/submit_success_dialog.dart';
import 'component/upload_success_dialog.dart';

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
  bool downloadFin = true;
  bool limitexdFile = false;
  String titleErrorMessage = '타이틀이 입력되지 않았어요';

  Future<void> _ficFile() async {
    result = await FilePicker.platform.pickFiles();
    if (result!.files.first.size > 3 * 1024 * 1024) {
      limitexdFile = true;
    } else {
      limitexdFile = false;
    }
  }

  Future<void> _uploadFile(
      String title, String contents, String parentPhone) async {
    final noticeViewModel = context.read<NoticeViewModel>();
    String downloadUrl = '';
    String filename = '';

    if (result != null) {
      PlatformFile file = result!.files.first;

      filename = file.name;

      // Firebase Storage에 파일 업로드
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('uploads/${DateTime.now().millisecondsSinceEpoch.toString()}');
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
        'filename': filename,
      };

      print(downloadUrl);

      String id = await noticeViewModel.setNotice(noticeMap);
      await noticeViewModel.getNotice(id);
      print(id);
      print(noticeViewModel.notice.toString());

      downloadFin = true;
      // 파일 업로드 및 데이터 저장 완료
      print('File uploaded and notice added to Firestore!');
      await showUploadSuccessDialog(context);
    } else {
      // 파일 크기가 3MB 초과
      await showSizeExceedDialog(context);
      print('File size exceeds 3MB. Please choose a smaller file.');

      downloadFin = false;
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

                if (title == '' || contents == '' || parentsPhone == '') {
                  String err = '';
                  if (title == '') {
                    err = '제목';
                  } else if (contents == '') {
                    err = '내용';
                  } else if (parentsPhone == '') {
                    err = '전화번호';
                  }
                  String ErrorMessage = '$err이 입력되지 않았어요';
                  if (limitexdFile) {
                    ErrorMessage = '3M가 이상파일은 첨부할 수 없습니다.';
                  }
                  downloadFin = false;
                  await showInputDialog(ErrorMessage, context);
                } else {
                  downloadFin = true;
                }

                if (downloadFin && !limitexdFile) {
                  await _uploadFile(title, contents, parentsPhone);
                  await submitSuccessDialog(context);
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
