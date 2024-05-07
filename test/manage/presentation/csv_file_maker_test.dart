import 'dart:convert';

import 'package:alimipro_mock_data/manage/data/utility/csv_maker_impl.dart';
import 'package:alimipro_mock_data/manage/domain/utility/csv_maker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('csv', () async {
    CsvMaker csvMaker = CsvMakerImpl();
    final testList = [
      {
        'academy': '테스터 학원',
        'name': '테스터',
        'time': Timestamp(1665178928, 628000000),
        'punchType': '등원'
      },
      {
        'academy': '테스터 학원',
        'name': '테스터',
        'time': Timestamp(1664789802, 913000000),
        'punchType': '하원'
      },
      {
        'academy': '테스터 학원',
        'name': '테스터',
        'time': Timestamp(1668989802, 934000000),
        'punchType': '하원'
      },
    ];
    final List<String> columnTitles = ['이름', '날짜', '시간', '등하원'];

    final List<String> columnContentsNames = ['name', 'time', 'punchType'];

    final data = await csvMaker.csvMaker(
      downloadcontents: testList,
      columnTitles: columnTitles,
      columnContentsNames: columnContentsNames,
      dateTimeSperate: true,
    );

    final csvdata = utf8.decode(data);
    String test =
        '이름,날짜,시간,등하원\n테스터,2022-10-08,06:42:08.62,등원\n테스터,2022-10-03,18:36:42.91,하원\n테스터,2022-11-21,09:16:42.93,하원';
    expect(csvdata.replaceAll(RegExp(r'[\n\r]'), ''),
        test.replaceAll(RegExp(r'[\n\r]'), ''));
  });
}
