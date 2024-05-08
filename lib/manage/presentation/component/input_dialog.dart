import 'package:flutter/material.dart';

Future<void> showInputDialog(String inputError, BuildContext context) async {
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