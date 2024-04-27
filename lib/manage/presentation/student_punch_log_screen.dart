import 'dart:convert';
import 'dart:io';

import 'package:alimipro_mock_data/manage/presentation/view_model/student_punch_log_view_model.dart';
import 'package:provider/provider.dart';

import '../domain/model/personal_punch_log.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:csv/csv.dart' as csv;

class StudentPunchLogScreen extends StatefulWidget {
  final Map<String, String> studentInfo;

  const StudentPunchLogScreen({super.key, required this.studentInfo});

  @override
  State<StudentPunchLogScreen> createState() => _StudentPunchLogScreenState();
}

class _StudentPunchLogScreenState extends State<StudentPunchLogScreen> {
  final Color _appBarColor = HexColor("#353A3F");
  List<PersonalPunchLog> logList = [];

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

  Future<void> exceldownload(List<PersonalPunchLog> logs) async {
    String fileName = '${widget.studentInfo['name']}등하원 내역.csv';

    List<List<dynamic>> csvData = [
      ['이름', '날짜', '시간', '등하원'],
      ...logs.map((e) => [
            e.name,
            e.time.toString().substring(0, 10),
            e.time.toString().substring(11, 22),
            e.punchType
          ]), // 기존 리스트 데이터 추가
    ];

    String csvString = const csv.ListToCsvConverter().convert(csvData);

    String directoryPath = '/storage/emulated/0/Download';
    Directory directory = Directory(directoryPath);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    String filePath = '$directoryPath/$fileName';

    File file = File(filePath);
    await file.writeAsString(csvString, encoding: utf8);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StudentPunchLogViewModel>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text('${widget.studentInfo['name']} 학생 등하원 기록',
                style: const TextStyle(color: Colors.white, fontSize: 35)),
            backgroundColor: _appBarColor,
            floating: true,
            pinned: false,
            // Enable pinning
            expandedHeight: 120.0,
            // Adjust height as needed
            flexibleSpace: const FlexibleSpaceBar(
              stretchModes: [StretchMode.fadeTitle],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 40.0,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              childCount: viewModel.punchLogs.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await exceldownload(logList);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('CSV 파일다운로드 완료'),
            ),
          );
        },
        backgroundColor: _appBarColor,
        tooltip: '출결정보 다운로드',
        child: const Icon(
          Icons.file_download,
          color: Colors.white,
        ),
      ),
    );
  }
}
