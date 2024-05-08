import 'package:flutter/material.dart';

Future<void> submitSuccessDialog(BuildContext context) async {
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