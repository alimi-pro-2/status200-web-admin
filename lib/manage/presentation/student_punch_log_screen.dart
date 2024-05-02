import 'package:alimipro_mock_data/manage/presentation/view_model/student_punch_log_view_model.dart';
import 'package:provider/provider.dart';
import '../data/utility/csv_file_download_impl.dart';
import '../data/utility/csv_maker_impl.dart';
import '../data/utility/excel_maker_impl.dart';
import '../data/utility/web_excel_file_download_impl.dart';
import '../domain/model/personal_punch_log.dart';
import 'package:flutter/material.dart';

import '../domain/utility/csv_file_download.dart';
import '../domain/utility/csv_maker.dart';
import '../domain/utility/excel_file_download.dart';
import '../domain/utility/excel_maker.dart';
import 'excel_download.dart';

class StudentPunchLogScreen extends StatefulWidget {
  final Map<String, String> studentInfo;

  const StudentPunchLogScreen({super.key, required this.studentInfo});

  @override
  State<StudentPunchLogScreen> createState() => _StudentPunchLogScreenState();
}

class _StudentPunchLogScreenState extends State<StudentPunchLogScreen> {
  List<PersonalPunchLog> logList = [];
  List<String> setList = ['15', '30', '60'];
  String dropdownValue = '15';
  ExcelFileDownload excelFileDownload = WebExcelFileDownloadImpl();
  ExcelMaker excelMaker = ExcelMakerImpl();
  ExcelDownload excelDownload = ExcelDownload();
  CsvFileDownload csvFileDownload = WebCsvFileDownloadImpl();
  CsvMaker csvMaker = CsvMakerImpl();

  @override
  void initState() {
    super.initState();

    //TODO: pastFromToday를 변수로 받아야 함. 오늘 부터 며칠 이전 까지의 기록을 받을 것 인지를 넘기는 곳
    Future.microtask(() {
      context.read<StudentPunchLogViewModel>().setPunchLogs(
            name: widget.studentInfo['name'] ?? '',
            parentPhone: widget.studentInfo['parentPhone'] ?? '',
            pastFromToday: 1200,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StudentPunchLogViewModel>();

    return SafeArea(
      child: Scaffold(
        body: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : viewModel.hasError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '등하원 기록이 존재하지 않습니다.',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('뒤로가기'),
                        )
                      ],
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          alignment: Alignment.center,
                          color: const Color(0xff353A3F),
                          height: 80,
                          child: Text(
                            '${widget.studentInfo['name']} 학생 등하원 기록',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),
                      SliverAppBar(
                        scrolledUnderElevation: 0,
                        elevation: 1,
                        pinned: true,
                        floating: true,
                        expandedHeight: 0.0,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              '날짜 설정',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 15),
                            DropdownButton(
                              value: dropdownValue,
                              items: setList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                                viewModel.setPunchLogs(
                                    name: widget.studentInfo['name'] ?? '',
                                    parentPhone:
                                        widget.studentInfo['parentPhone'] ?? '',
                                    pastFromToday: int.parse(dropdownValue));
                              },
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () async {
                                /*   await excelDownload
                                    .csvDownload(viewModel.punchLogs);*/

                                final List<String> columnTitles = [
                                  '이름',
                                  '날짜',
                                  '시간',
                                  '등하원'
                                ];
                                final String fileName =
                                    '${viewModel.punchLogs[0].name} 등하원내역';

                                final param = viewModel.punchLogs
                                    .map((e) => e.toJson())
                                    .toList();
                                final List<String> columnContentsNames = [
                                  'name',
                                  'time',
                                  'punchType'
                                ];

                                final String csvdata = await csvMaker.csvMaker(
                                  downloadcontents: param,
                                  columnTitles: columnTitles,
                                  columnContentsNames: columnContentsNames,
                                  dateTimeSperate: true,
                                );
                                await csvFileDownload.csvFileDownload(
                                    csvdata: csvdata, fileName: fileName);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('CSV 파일다운로드 완료'),
                                  ),
                                );
                              },
                              child: const Row(
                                children: [
                                  Text(
                                    'csv',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Icon(Icons.file_download),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            GestureDetector(
                              onTap: () async {
                                final List<String> columnTitles = [
                                  '이름',
                                  '날짜',
                                  '시간',
                                  '등하원'
                                ];
                                final String fileName =
                                    '${viewModel.punchLogs[0].name} 등하원내역';

                                final param = viewModel.punchLogs
                                    .map((e) => e.toJson())
                                    .toList();
                                final List<String> columnContentsNames = [
                                  'name',
                                  'time',
                                  'punchType'
                                ];
                                final excelfile = await excelMaker.excelMaker(
                                  downloadcontents: param,
                                  columnTitles: columnTitles,
                                  columnContentsNames: columnContentsNames,
                                  dateTimeSperate: true,
                                );
                               await excelFileDownload.excelFileDownload(
                                    excel: excelfile, fileName: fileName);
                                // await excelFileDownload.excelFileDownload(excel:excelfile, fileName:fileName);

/*                                await excelDownload.excelDownloadMapList(
                                  param,
                                  fileName,
                                  columnTitles,
                                  haederName,
                                  dateTimeSperate: true,
                                );*/
                              },
                              child: const Row(children: [
                                Text(
                                  'excel',
                                  style: TextStyle(fontSize: 25),
                                ),
                                Icon(Icons.file_download),
                              ]),
                            ),
                          ],
                        ),
                      ),
                      SliverFixedExtentList(
                        itemExtent: 40.0,
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.center,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Text('이름', style: TextStyle(fontSize: 20)),
                                SizedBox(
                                  width: 75,
                                ),
                                Text('날짜', style: TextStyle(fontSize: 20)),
                                SizedBox(
                                  width: 85,
                                ),
                                Text('시간', style: TextStyle(fontSize: 20)),
                                SizedBox(
                                  width: 40,
                                ),
                                Text('등하원', style: TextStyle(fontSize: 20)),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          );
                        }, childCount: 1),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Divider(
                                  color: Colors.grey,
                                ),
                                Column(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(viewModel.punchLogs[index].name,
                                          style: const TextStyle(fontSize: 20)),
                                      Text(
                                          viewModel.punchLogs[index].time
                                              .toString()
                                              .substring(0, 10),
                                          style: const TextStyle(fontSize: 20)),
                                      Text(
                                          viewModel.punchLogs[index].time
                                              .toString()
                                              .substring(11, 22),
                                          style: const TextStyle(fontSize: 20)),
                                      Text(viewModel.punchLogs[index].punchType,
                                          style: const TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                ])
                              ],
                            );
                          },
                          childCount: viewModel.hasError
                              ? 1
                              : viewModel.punchLogs.length,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
