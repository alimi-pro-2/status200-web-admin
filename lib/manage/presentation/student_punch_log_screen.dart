import 'dart:convert';
import 'dart:io';

import '../domain/model/personal_punch_log.dart';
import '../domain/repository/academy_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:csv/csv.dart' as csv;

class StudentPunchLogScreen extends StatelessWidget {
  final AcademyRepository academyRepository;
  final String name;
  final String parentPhone;

  const StudentPunchLogScreen(
      {super.key,
      required this.academyRepository,
      required this.name,
      required this.parentPhone});

  @override
  Widget build(BuildContext context) {
    Color appBarColor = HexColor("#353A3F");
    List<PersonalPunchLog> logList = [];
    return Scaffold(
      body: FutureBuilder<List<PersonalPunchLog>>(
        future: academyRepository.getStudentPunchLogs(name, parentPhone),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('값 없음'));
          }
          logList = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                title: Text('$name 학생 등하원 기록',
                    style: TextStyle(color: Colors.white, fontSize: 35)),
                backgroundColor: appBarColor,
                floating: true,
                pinned: false,
                // Enable pinning
                expandedHeight: 120.0,
                // Adjust height as needed
                flexibleSpace: FlexibleSpaceBar(
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
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    child: Row(
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
                        Divider(
                          color: Colors.grey,
                        ),
                        Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('${snapshot.data![index].name}',
                                  style: TextStyle(fontSize: 20)),
                              // const SizedBox(width: 30),
                              Text(
                                  '${snapshot.data![index].time.toString().substring(0, 10)}',
                                  style: TextStyle(fontSize: 20)),
                              // const SizedBox(width: 30),
                              Text(
                                  '${snapshot.data![index].time.toString().substring(11, 22)}',
                                  style: TextStyle(fontSize: 20)),
                              // const SizedBox(width: 30),
                              Text('${snapshot.data![index].punchType}',
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ])
                      ],
                    );
                  },
                  childCount: snapshot.data!.length,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String fileName = '${logList[0].name}등하원 내역.csv';

          List<List<dynamic>> csvData = [
            ['이름', '날짜', '시간', '등하원'],
            ...logList.map((e) => [
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

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('CSV 파일다운로드 완료'),
            ),
          );
        },
        child: Icon(
          Icons.file_download,
          color: Colors.white,
        ),
        backgroundColor: appBarColor,
        tooltip: '출결정보 다운로드',
      ),
    );
  }
}
