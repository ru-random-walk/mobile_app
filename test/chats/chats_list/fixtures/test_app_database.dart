import 'package:core/core.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

class TestAppDatabase extends AppDatabase {
  TestAppDatabase._() : super(_openMemoryConnection());

  static final TestAppDatabase _instance = TestAppDatabase._();

  static TestAppDatabase get instance => _instance;

  static QueryExecutor _openMemoryConnection() {
    return NativeDatabase.memory();
  }

  @override
  int get schemaVersion => 1;
}
