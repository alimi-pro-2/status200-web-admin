import 'package:alimipro_mock_data/manage/data/utility/excel_maker_impl.dart';
import 'package:alimipro_mock_data/manage/domain/utility/file_maker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('exceltest', () async {
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
      }
    ];

    final List<String> columnTitles = ['이름', '날짜', '시간', '등하원'];

    final List<String> columnContentsNames = ['name', 'time', 'punchType'];

    FileMaker excelMaker = ExcelMakerImpl();

    final exceldata = await excelMaker.fileMaker(
      downloadContents: testList,
      columnTitles: columnTitles,
      columnContentsNames: columnContentsNames,
      dayTimeSeparator: true,
    );

    Excel excelfile = Excel.decodeBytes(exceldata);

    final excelcontent = await excelfile.sheets['Sheet1']!
        .cell(CellIndex.indexByString('A3'))
        .value
        .toString();
    expect(excelcontent, '테스터');
    final excelcontent1 = await excelfile.sheets['Sheet1']!
        .cell(CellIndex.indexByString('B3'))
        .value
        .toString();
    expect(excelcontent1, '2022-10-03');

    final excelcontent3 = await excelfile.sheets['Sheet1']!
        .cell(CellIndex.indexByString('C3'))
        .value
        .toString();
    expect(excelcontent3, '18:36:42.91');
    final excelcontent4 = await excelfile.sheets['Sheet1']!
        .cell(CellIndex.indexByString('D3'))
        .value
        .toString();
    expect(excelcontent4, '하원');
  });
}
