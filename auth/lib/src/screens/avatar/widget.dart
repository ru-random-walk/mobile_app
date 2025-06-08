import 'package:auth/auth.dart';
import 'package:auth/src/data/repositories/avatar_cache.dart';
import 'package:auth/src/data/repositories/avatars_info.dart';
import 'package:auth/src/domain/usecases/user/get_avatar.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvatarUserWidget extends StatelessWidget {
  final UserEntity user;
  final double size;

  const AvatarUserWidget({
    super.key,
    required this.user,
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
          create: (context) => GetUserAvatarUseCase(
            getImageRepository: context.read<UserRepository>(),
            dbInfo: context.read<UserAvatarsDatabaseInfoRepository>(),
            cache: context.read<AvatarCacheRepository>(),
          ),
        ),
      ],
      child: Builder(builder: (context) {
        return CachedImageWidget(
          getPhotoArgs: user,
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
          getPhotoUseCase: context.read<GetUserAvatarUseCase>(),
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
