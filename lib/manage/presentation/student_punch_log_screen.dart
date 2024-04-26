import 'package:alimipro_mock_data/manage/domain/model/personal_punch_log.dart';
import 'package:alimipro_mock_data/manage/domain/repository/academy_repository.dart';
import 'package:flutter/material.dart';

class StudentPunchLogScreen extends StatelessWidget {
  final AcademyRepository academyRepository;
  final String name;
  final String parentPhone;

  const StudentPunchLogScreen({super.key,
    required this.academyRepository,
    required this.name,
    required this.parentPhone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('$name 학생 등하원 기록')
      ),
      body: FutureBuilder<List<PersonalPunchLog>>(
        future: academyRepository.getStudentPunchLogs(name, parentPhone),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('값 없음'));
          }

          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!.map((punchLog) {
                return Row(
                  children: [
                    Text('${punchLog.name}'),
                    const SizedBox(width:8),
                    Text('${punchLog.time}'),
                    const SizedBox(width:8),
                    Text('${punchLog.punchType}'),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
