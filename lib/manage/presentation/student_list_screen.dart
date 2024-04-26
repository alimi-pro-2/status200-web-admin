import 'package:alimipro_mock_data/manage/domain/model/academy.dart';
import 'package:alimipro_mock_data/manage/domain/model/student.dart';
import 'package:alimipro_mock_data/manage/domain/repository/academy_repository.dart';
import 'package:alimipro_mock_data/manage/presentation/student_punch_log_screen.dart';
import 'package:flutter/material.dart';

class StudentListScreen extends StatelessWidget {
  final AcademyRepository academyRepository;
  final String uid;

  const StudentListScreen({super.key, required this.academyRepository, required this.uid});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Alimipro 샘플'),
        ),
        body: Column(
          children: [
            FutureBuilder<Academy>(
              future: academyRepository.getAcademy(uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('값 없음'));
                }

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('학원명: ${snapshot.data!.name}'),
                          SizedBox(width: 16),
                          Text('대표번호: ${snapshot.data!.phone}'),
                        ],
                      ),
                      Text('학원장: ${snapshot.data!.master}'),
                    ],
                  ),
                );
              },
            ),
            FutureBuilder<List<Student>>(
                future: academyRepository.getStudents(uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: Text('값 없음'));
                  }

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('상태'),
                              Text('반'),
                              Text('이름'),
                              Text('출결코드'),
                              Text('대표 보호자 번호'),
                              Text('메모'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView(
                              children: snapshot.data!.map((student) {
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(student.status ?? ''),
                                    Text(student.classValue!),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StudentPunchLogScreen(
                                                      academyRepository:
                                                      academyRepository,
                                                      name: student.name,
                                                      parentPhone: student.parentsPhone1)),
                                        );
                                      },
                                      child: Text(student.name),
                                    ),
                                    Text(student.pin),
                                    Text(student.parentsPhone1),
                                    Text(student.memo!),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ));
  }
}
