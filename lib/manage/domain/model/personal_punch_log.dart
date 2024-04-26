import 'package:alimipro_mock_data/manage/data/mapper/date_time_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_punch_log.freezed.dart';

part 'personal_punch_log.g.dart';

@freezed
class PersonalPunchLog with _$PersonalPunchLog {
  const factory PersonalPunchLog({
    required String academy,
    required String name,
    @DateTimeConverter() required DateTime time,
    required String punchType
  }) = _PersonalPunchLog;

  factory PersonalPunchLog.fromJson(Map<String, Object?> json) =>
      _$PersonalPunchLogFromJson(json);
}
