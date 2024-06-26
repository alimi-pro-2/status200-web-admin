
import 'package:injectable/injectable.dart';
import '../../domain/model/notice.dart';
import '../../domain/repository/notice_repository.dart';
import '../data_source/notice_data_source.dart';


@Singleton(as: NoticeRepository)
class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeDataSource _noticeDataSource;

  @override
  Future<Notice> getNotice(String uid) async {
    final documentRef = _noticeDataSource.getNoticeDocumentRef(uid);
    final documentSnapshot = await documentRef.get();

    if (!documentSnapshot.exists) {
      throw Exception('등록되지 않은 Notice 입니다.');
    }

    return Notice.fromJson(documentSnapshot.data()!);
  }

  @override
  Future<String> setNotice(Notice notice) async {
    final documentRef = await _noticeDataSource.setNoticeDocumentRef(notice);
    String? id = await documentRef.id;

    if (id.isEmpty) {
      throw Exception('등록되지 않앗습니다');
    }

    return id;
  }

  const NoticeRepositoryImpl({
    required NoticeDataSource noticeDataSource,
  }) : _noticeDataSource = noticeDataSource;
}
