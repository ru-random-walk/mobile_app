import 'package:core/core.dart';
import 'package:drift/drift.dart';

class ClubPhotoDatabaseInfoDataSource {
  final AppDatabase appDatabase;

  ClubPhotoDatabaseInfoDataSource(this.appDatabase);

  Future<CachedClubsAvatarData?> getClubPhotoInfo(String clubId) async {
    return (appDatabase.select(appDatabase.cachedClubsAvatar)
          ..where((tbl) => tbl.clubId.equals(clubId)))
        .getSingleOrNull();
  }

  Future<void> addClubPhotoInfo(String clubId, int photoVersion) async {
    await appDatabase.into(appDatabase.cachedClubsAvatar).insert(
        CachedClubsAvatarCompanion.insert(
          photoVersion: photoVersion,
          clubId: clubId,
        ),
        mode: InsertMode.insertOrReplace);
  }
}
