import 'package:alimipro_mock_data/manage/presentation/student_punch_log_screen.dart';
import 'package:flutter/material.dart';

import '../domain/model/academy.dart';
import '../domain/model/student.dart';
import '../domain/repository/academy_repository.dart';

class AcademyStudentListScreen extends StatefulWidget {
  final AcademyRepository academyRepository;
  final String uid;
  const AcademyStudentListScreen({
    Key? key,
    required this.academyRepository,
    required this.uid,
  }) : super(key: key);

  @override
  State<AcademyStudentListScreen> createState() =>
      _AcademyStudentListScreenState();
}

class _AcademyStudentListScreenState extends State<AcademyStudentListScreen> {
  bool _isNameAscending = true;
  final textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학생 명단'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
          future: Future.wait([
            widget.academyRepository.getAcademy(widget.uid),
            widget.academyRepository.getStudents(widget.uid),
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final academyData = snapshot.data![0] as Academy;
            final studentsData = snapshot.data![1] as List<Student>;

            if (!_isNameAscending) {
              studentsData.sort((a, b) => b.name.compareTo(a.name));
            } else {
              studentsData.sort((a, b) => a.name.compareTo(b.name));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '학원명 : ${academyData.name}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text('학원장 : ${academyData.master}'),
                      Text('대표번호 : ${academyData.phone}'),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    decoration: const BoxDecoration(
                      color: Color(0xff353A3F),
                    ),
                    columns: [
                      DataColumn(
                        label: Text(
                          '상태',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      DataColumn(
                          label: Text(
                        '반',
                        style: TextStyle(color: textColor),
                      )),
                      DataColumn(
                          label: GestureDetector(
                        child: Row(
                          children: [
                            Text(
                              '이름 ',
                              style: TextStyle(color: textColor),
                            ),
                            _isNameAscending
                                ? Icon(
                                    Icons.arrow_drop_down,
                                    color: textColor,
                                  )
                                : Icon(
                                    Icons.arrow_drop_up,
                                    color: textColor,
                                  ),
                          ],
                        ),
                        onTap: () {
                          _isNameAscending = !_isNameAscending;
                          setState(() {});
                        },
                      )),
                      DataColumn(
                          label: Text(
                        '출결코드',
                        style: TextStyle(color: textColor),
                      )),
                      DataColumn(
                          label: Text(
                        '대표 보호자 번호',
                        style: TextStyle(color: textColor),
                      )),
                      DataColumn(
                          label: Text(
                        '메모',
                        style: TextStyle(color: textColor),
                      )),
                    ],
                    rows: studentsData.map((student) {
                      return DataRow(
                          color: MaterialStateColor.resolveWith((states) {
                            return Colors.white;
                          }),
                          cells: [
                            DataCell(Text(student.status ?? '')),
                            DataCell(Text(student.classValue!)),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StudentPunchLogScreen(
                                        academyRepository:
                                            widget.academyRepository,
                                        name: student.name,
                                        parentPhone: student.parentsPhone1,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(student.name),
                              ),
                            ),
                            DataCell(Text(student.pin)),
                            DataCell(Text(student.parentsPhone1)),
                            DataCell(Text(student.memo!)),
                          ]);
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
