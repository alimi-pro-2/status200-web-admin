import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/mapper/date_time_converter.dart';

part 'notice.freezed.dart';

part 'notice.g.dart';

@freezed
class Notice with _$Notice {
  const factory Notice({
    @DateTimeConverter() required DateTime date,
    required String academy,
    required String contents,
    required String parentsPhone,
    required String pushType,
    required String title,
    String? fileUrl,
    String? filename,
  }) = _Notice;

  factory Notice.fromJson(Map<String, Object?> json) =>
      _$NoticeFromJson(json);
}