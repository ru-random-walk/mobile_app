import 'package:drift/drift.dart';

class CachedClubsAvatar extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clubId => text()();
  IntColumn get photoVersion => integer()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [{clubId}];
}
