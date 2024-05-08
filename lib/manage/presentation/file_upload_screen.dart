import 'package:alimipro_mock_data/manage/presentation/view_model/notice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

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
  String titleErrorMessage = '타이틀이 입력되지 않았어요';

  Future<void> _ficFile() async {
    result = await FilePicker.platform.pickFiles();
  }

  Future<void> _uploadFile(
      String title, String contents, String parentPhone) async {
    final noticeViewModel = context.read<NoticeViewModel>();
    String downloadUrl = '';
    String filename = '';

    if (result != null) {
      PlatformFile file = result!.files.first;

      if (file.size <= 3 * 1024 * 1024) {
        filename = file.name;

        // Firebase Storage에 파일 업로드
        Reference storageRef = FirebaseStorage.instance.ref().child(
            'uploads/${DateTime.now().millisecondsSinceEpoch.toString()}');
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
        await _showUploadSuccessDialog();
      } else {
        // 파일 크기가 3MB 초과
        await _showSizeExceedDialog();
        print('File size exceeds 3MB. Please choose a smaller file.');
        downloadFin = false;
      }
    } else {
      // 파일이 선택되지 않은 경우
      print('No file selected!');
    }
  }

  // 파일 크기 초과 경고 다이얼로그 표시
  Future<void> _showSizeExceedDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('파일 사이즈가 3mb를 초과했습니다.'),
          content: const Text('업로드 하려는 파일의 사이즈를 3mb 이하로 선택해주세요.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // 파일 크기 초과 경고 다이얼로그 표시
  Future<void> _showUploadSuccessDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('파일 업로드가 완료되었습니다.'),
          content: const Text('업로드된 파일은 학부모 앱에서 다운이 가능합니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // 텍스트 컨트롤러 다이얼로그 표시
  Future<void> _showInputDialog(String inputError) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('내용이 작성되지 않았습니다.'),
          content: Text(inputError),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // submit 확인 다이얼로그
  Future<void> _submitSuccessDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('전송이 완료되었습니다.'),
          content: const Text('이전 화면으로 돌아갑니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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

                if (title == '' ||
                    contents == '' ||
                    parentsPhone == '') {
                  String err = '';
                  if (title == '') {
                    err = '제목';
                  } else if (contents == '') {
                    err = '내용';
                  } else if (parentsPhone == '') {
                    err = '전화번호';
                  }
                  String ErrorMessage = '$err이 입력되지 않았어요';
                  downloadFin = false;
                  await _showInputDialog(ErrorMessage);
                } else {
                  downloadFin = true;
                }

                if (downloadFin) {
                  await _submitSuccessDialog();
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
