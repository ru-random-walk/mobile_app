import 'package:drift/drift.dart';

class CachedUserAvatar extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  IntColumn get photoVersion => integer()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [{userId}];
}
