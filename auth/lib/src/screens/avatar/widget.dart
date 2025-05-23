import 'package:auth/auth.dart';
import 'package:auth/src/data/repositories/avatar_cache.dart';
import 'package:auth/src/data/repositories/avatars_info.dart';
import 'package:auth/src/data/repositories/user.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarUserWidget extends StatelessWidget {
  final String userId;
  final int photoVersion;
  final double size;

  const AvatarUserWidget({
    super.key,
    required this.userId,
    required this.photoVersion,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => UserRepository(
            UsersDataSource(),
          ),
        ),
        Provider(
          create: (context) => AvatarCacheRepository(),
        ),
        Provider(
          create: (context) => UserAvatarsDatabaseInfoRepository(
            context.read(),
          ),
        ),
        Provider(
          create: (context) => GetPhotoForObjectWithId(
            getImageRepository: context.read<UserRepository>(),
            dbInfo: context.read<UserAvatarsDatabaseInfoRepository>(),
            cache: context.read<AvatarCacheRepository>(),
          ),
        ),
      ],
      child: Builder(builder: (context) {
        return CachedImageWidget(
          objectId: userId,
          photoVersion: photoVersion,
          emptyBuilder: () => _wrap(
            Image.asset(
              'packages/clubs/assets/images/avatar.png',
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          ),
          dataBuilder: (bytes) => _wrap(
            Image.memory(
              bytes,
              fit: BoxFit.cover,
            ),
          ),
          getPhotoUseCase: context.read(),
        );
      }),
    );
  }

  Widget _wrap(Widget child) => SizedBox.square(
        dimension: size,
        child: ClipOval(
          child: child,
        ),
      );
}
