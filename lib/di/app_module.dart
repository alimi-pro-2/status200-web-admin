import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @lazySingleton
  FirebaseFirestore get fireabaseFirestore =>
      FirebaseFirestore.instance..useFirestoreEmulator('localhost', 8080);
}
