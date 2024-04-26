import 'package:alimipro_mock_data/manage/data/data_source/academy_data_source.dart';
import 'package:alimipro_mock_data/manage/data/data_source/log_data_source.dart';
import 'package:alimipro_mock_data/manage/presentation/academy_student_list_screen.dart';
import 'package:alimipro_mock_data/manage/presentation/student_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'manage/data/repository/firebase_academy_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final db = FirebaseFirestore.instance..useFirestoreEmulator('10.0.2.2', 8080);

  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final FirebaseFirestore db;

  const MyApp({
    super.key,
    required this.db,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AcademyStudentListScreen(
        academyRepository: FirebaseAcademyRepositoryImpl(
          academyDataSource: AcademyDataSource(firebaseFirestore: db),
          logDataSource: LogDataSource(firebaseFirestore: db),
        ),
        uid: '2rkvZ4XPwqfVdIBmmBVPRm4sVcB3',
      ),
    );
  }
}
