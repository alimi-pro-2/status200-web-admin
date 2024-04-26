import '../domain/model/personal_punch_log.dart';
import '../domain/repository/academy_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Text('이름', style: TextStyle(fontSize: 12)),
                      //     const SizedBox(width: 40),
                      //     Text('날짜', style: TextStyle(fontSize: 12)),
                      //     const SizedBox(width: 40),
                      //     Text('시간', style: TextStyle(fontSize: 12)),
                      //     const SizedBox(width: 40),
                      //     Text('등하원 정보', style: TextStyle(fontSize: 12)),
                      //   ],
                      // ),
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
                    child:  Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('이름', style: TextStyle(fontSize: 20)),

                            Text('날짜', style: TextStyle(fontSize: 20)),

                            Text('시간', style: TextStyle(fontSize: 20)),

                            Text('등하원 정보', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
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
        onPressed: () {},
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
