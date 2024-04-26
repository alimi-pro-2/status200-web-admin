import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final db = FakeFirebaseFirestore();

  setUp(() async {
    await db
        .collection('test')
        .doc('id01')
        .set({'title': 'title', 'body': 'body'});
  });

  group('firestore', () {
    test('get()', () async {
      final result = await db.collection('test').doc('id01').get();
      expect(result.data()!['title'], equals('title'));
      expect(result.data()!['body'], equals('body'));
    });

    test('snapshot()', () async {
      final result = await db.collection('test').snapshots().first;

      expect(result.docs.length, equals(1));
      expect(result.docs.first.data()['title'], equals('title'));
      expect(result.docs.first.data()['body'], equals('body'));
    });
  });
}
