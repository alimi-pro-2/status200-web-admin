import 'package:flutter/material.dart';

Future<void> showSizeExceedDialog(BuildContext context) async {
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