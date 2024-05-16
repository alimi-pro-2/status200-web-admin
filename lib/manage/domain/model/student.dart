// ignore_for_file: type=lint

import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';

part 'student.g.dart';

@freezed
class Student with _$Student {
  const factory Student({
    required String name,
    required String parentsPhone1,
    required String uid,
    @JsonKey(name: 'PIN') required String pin,
    @JsonKey(name: 'class') @Default('') String? classValue,
    @Default('특이사항없음') String? memo,
    @Default('') String? status,
  }) = _Student;

  factory Student.fromJson(Map<String, Object?> json) => _$StudentFromJson(json);
}