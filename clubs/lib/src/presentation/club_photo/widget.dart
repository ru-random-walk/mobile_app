import 'dart:typed_data';

import 'package:clubs/src/data/db/data_source/club_photo.dart';
import 'package:clubs/src/data/image/repository/cache.dart';
import 'package:clubs/src/data/image/repository/sender.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClubPhotoWidget extends StatelessWidget {
  final String clubId;
  final int photoVersion;

  final Widget Function() loadingBuilder;
  final Widget Function() errorBuilder;
  final Widget Function(Uint8List bytes) dataBuilder;
  final Widget Function() emptyBuilder;

  const ClubPhotoWidget({
    super.key,
    required this.clubId,
    required this.photoVersion,
    required this.loadingBuilder,
    required this.errorBuilder,
    required this.dataBuilder,
    required this.emptyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => RemoteImageClubRepostory(),
        ),
        Provider(
          create: (context) => CacheClubImageRepository(),
        ),
        Provider(
          create: (context) => ClubPhotoDatabaseInfoDataSource(
            context.read(),
          ),
        ),
        Provider(
          create: (context) => GetPhotoForObjectWithId(
            getImageRepository: context.read<RemoteImageClubRepostory>(),
            dbInfo: context.read<ClubPhotoDatabaseInfoDataSource>(),
            cache: context.read<CacheClubImageRepository>(),
          ),
        ),
      ],
      child: Builder(builder: (context) {
        return CachedImageWidget(
          objectId: clubId,
          photoVersion: photoVersion,
          loadingBuilder: loadingBuilder,
          errorBuilder: errorBuilder,
          dataBuilder: dataBuilder,
          emptyBuilder: emptyBuilder,
          getPhotoUseCase: context.read(),
        );
      }),
    );
  }
}
