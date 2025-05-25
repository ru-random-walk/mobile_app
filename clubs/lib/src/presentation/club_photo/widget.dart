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

  final double size;

  final Widget Function(Uint8List bytes) dataBuilder;
  final Widget Function() emptyBuilder;

  const ClubPhotoWidget({
    super.key,
    required this.clubId,
    required this.photoVersion,
    required this.dataBuilder,
    required this.emptyBuilder,
    required this.size,
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
        return Center(
          child: SizedBox.square(
            dimension: size,
            child: CachedImageWidget(
              getPhotoArgs: GetObjectPhotoArgs(
                objectId: clubId,
                photoVersion: photoVersion,
              ),
              dataBuilder: dataBuilder,
              getPhotoUseCase: context.read(),
              emptyBuilder: emptyBuilder,
            ),
          ),
        );
      }),
    );
  }
}
