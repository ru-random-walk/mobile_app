import 'package:core/core.dart';
import 'package:drift/drift.dart';

class UserAvatarsDatabaseInfoRepository implements LocalImageInfoRepository {
  final AppDatabase appDatabase;

  UserAvatarsDatabaseInfoRepository(this.appDatabase);

  @override
  Future<LocalImageInfo?> getImageInfo(String objectId) async {
    final res = await (appDatabase.select(appDatabase.cachedUserAvatar)
          ..where((tbl) => tbl.userId.equals(objectId)))
        .getSingleOrNull();
    if (res == null) return null;
    return LocalImageInfo(
      objectId: objectId,
      version: res.photoVersion,
    );
  }

  @override
  Future<void> saveImageInfo(LocalImageInfo imageInfo) async {
    await appDatabase.into(appDatabase.cachedUserAvatar).insert(
          CachedUserAvatarCompanion.insert(
            photoVersion: imageInfo.version,
            userId: imageInfo.objectId,
          ),
          mode: InsertMode.insertOrReplace,
        );
  }
}
