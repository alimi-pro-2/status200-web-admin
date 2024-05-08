import 'package:flutter/material.dart';

Future<void> showUploadSuccessDialog(BuildContext context) async {
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