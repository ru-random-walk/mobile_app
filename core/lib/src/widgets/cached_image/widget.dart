import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core/src/widgets/cached_image/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_utils/ui_utils.dart';

class CachedImageWidget extends StatelessWidget {
  final String objectId;
  final int photoVersion;

  final GetPhotoForObjectWithId getPhotoUseCase;

  final Widget Function(Uint8List bytes) dataBuilder;
  final Widget Function()? emptyBuilder;

  const CachedImageWidget({
    super.key,
    required this.objectId,
    required this.photoVersion,
    required this.dataBuilder,
    required this.getPhotoUseCase,
    this.emptyBuilder,
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
                ClubPhotoLoading _ => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ClubPhotoError _ => const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
                final ClubPhotoData data => dataBuilder(data.file),
                ClubPhotoEmpty _ => emptyBuilder?.call() ??
                    Center(
                      child: FittedBox(
                        child: Text(
                          'Нет фото',
                          style: context.textTheme.captionMedium,
                        ),
                      ),
                    ),
              };
            },
          );
        },
      ),
    );
  }
}
