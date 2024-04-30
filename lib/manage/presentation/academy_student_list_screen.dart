import 'package:alimipro_mock_data/manage/presentation/view_model/academy_student_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'excel_download.dart';

class AcademyStudentListScreen extends StatefulWidget {
  const AcademyStudentListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AcademyStudentListScreen> createState() =>
      _AcademyStudentListScreenState();
}

class _AcademyStudentListScreenState extends State<AcademyStudentListScreen> {
  bool _isNameAscending = true;
  final textColor = Colors.white;
  ExcelDownload excelDownload = ExcelDownload();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<AcademyStudentListViewModel>()
          .setAcademy('0eC7zE8XXSFuH2ZzaHCc');
      context
          .read<AcademyStudentListViewModel>()
          .setStudents('0eC7zE8XXSFuH2ZzaHCc');
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AcademyStudentListViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('학생 명단'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final List<String> columnTitles = [
            '이름',
            '출결코드',
            '대표 보호자 번호',
            '메모',
          ];
          final String fileName = '${viewModel.academy.name} 학생명단';

          final param = viewModel.students.map((e) => e.toJson()).toList();

          final List<String> haederName = [
            'name',
            'PIN',
            'parentsPhone1',
            'memo',
          ];
          await excelDownload.excelDownloadMapList(
            param,
            fileName,
            columnTitles,
            haederName,
          );
        },
      ),
    );
  }
}
