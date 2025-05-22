import 'dart:typed_data';

import 'package:clubs/src/data/club_photo/club_photo.dart';
import 'package:clubs/src/data/db/data_source/club_photo.dart';
import 'package:clubs/src/domain/usecase/get_club_photo.dart';
import 'package:clubs/src/presentation/club_photo/logic/cubit/club_photo_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          create: (context) => ClubPhotoDataSource(),
        ),
        Provider(
          create: (context) => CacheImagesDataSource(),
        ),
        Provider(
          create: (context) => ClubPhotoDatabaseInfoDataSource(
            context.read(),
          ),
        ),
        Provider(
          create: (context) => GetClubPhotoUseCase(
            clubPhotoDataSource: context.read(),
            clubPhotoDatabaseInfoDataSource: context.read(),
            cacheImagesDataSource: context.read(),
          ),
        ),
      ],
      child: BlocProvider(
        key: ValueKey(clubId),
        create: (context) => ClubPhotoCubit(
          clubId: clubId,
          photoVersion: photoVersion,
          getClubPhoto: context.read(),
        ),
        child: Builder(
          builder: (context) {
            return BlocBuilder<ClubPhotoCubit, ClubPhotoState>(
              builder: (context, state) {
                return switch (state) {
                  ClubPhotoLoading _ => loadingBuilder(),
                  ClubPhotoError _ => errorBuilder(),
                  final ClubPhotoData data => dataBuilder(data.file),
                  ClubPhotoEmpty _ => emptyBuilder(),
                };
              },
            );
          },
        ),
      ),
    );
  }
}
