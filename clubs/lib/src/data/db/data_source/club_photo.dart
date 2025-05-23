import 'package:core/core.dart';
import 'package:drift/drift.dart';

class ClubPhotoDatabaseInfoDataSource implements LocalImageInfoRepository {
  final AppDatabase appDatabase;

  ClubPhotoDatabaseInfoDataSource(this.appDatabase);

  @override
  Future<LocalImageInfo?> getImageInfo(String objectId) async {
    final res = await (appDatabase.select(appDatabase.cachedClubsAvatar)
          ..where((tbl) => tbl.clubId.equals(objectId)))
        .getSingleOrNull();
    if (res == null) return null;
    return LocalImageInfo(
      objectId: objectId,
      version: res.photoVersion,
    );
  }

  @override
  Future<void> saveImageInfo(LocalImageInfo imageInfo) async {
    await appDatabase.into(appDatabase.cachedClubsAvatar).insert(
        CachedClubsAvatarCompanion.insert(
          photoVersion: imageInfo.version,
          clubId: imageInfo.objectId,
        ),
        mode: InsertMode.insertOrReplace);
  }
}
