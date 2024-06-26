import 'package:alimipro_mock_data/manage/presentation/view_model/academy_student_list_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class AcademyStudentListScreen extends StatefulWidget {
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  AcademyStudentListScreen({
    super.key,
  });

  @override
  State<AcademyStudentListScreen> createState() =>
      _AcademyStudentListScreenState();
}

class _AcademyStudentListScreenState extends State<AcademyStudentListScreen> {
  bool _isNameAscending = true;
  final textColor = Colors.white;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AcademyStudentListViewModel>().setAcademy(widget._uid);
      context.read<AcademyStudentListViewModel>().setStudents(widget._uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AcademyStudentListViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('학생 명단'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '학원명 : ${viewModel.academy.name}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text('학원장 : ${viewModel.academy.master}'),
                          Text('대표번호 : ${viewModel.academy.phone}'),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        final data = {
                          'name': viewModel.academy.name,
                        };

                        context.push('/notice', extra: data);
                      },
                      child: const Text('공지사항입력'),
                    )
                  ],
                ),
                DataTable(
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
                        viewModel.sortStudents(_isNameAscending);
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
                  rows: viewModel.students.map((student) {
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
                                final data = {
                                  'name': student.name,
                                  'parentPhone': student.parentsPhone1,
                                };

                                context.push('/studentList/punchLogs',
                                    extra: data);
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.2),
            child: FloatingActionButton(
              backgroundColor: const Color(0xff353A3F),
              heroTag: null,
              onPressed: () async {
                viewModel.excelDownload();
              },
              child: const Text(
                'Excel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: const Color(0xff353A3F),
              heroTag: null,
              onPressed: () async {
                viewModel.csvDownload();
              },
              child: const Text(
                'CSV',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
