import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core/src/widgets/cached_image/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CachedImageWidget extends StatelessWidget {
  final String objectId;
  final int photoVersion;

  final GetPhotoForObjectWithId getPhotoUseCase;

  final Widget Function() loadingBuilder;
  final Widget Function() errorBuilder;
  final Widget Function(Uint8List bytes) dataBuilder;
  final Widget Function() emptyBuilder;

  const CachedImageWidget({
    super.key,
    required this.objectId,
    required this.photoVersion,
    required this.loadingBuilder,
    required this.errorBuilder,
    required this.dataBuilder,
    required this.emptyBuilder,
    required this.getPhotoUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey(objectId),
      create: (context) => CachedImageCubit(
        objectId: objectId,
        photoVersion: photoVersion,
        getClubPhoto: getPhotoUseCase,
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<CachedImageCubit, CachedImageState>(
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
    );
  }
}
