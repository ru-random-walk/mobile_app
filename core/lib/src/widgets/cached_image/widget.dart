import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core/src/widgets/cached_image/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_utils/ui_utils.dart';

class CachedImageWidget<Arg extends GetObjectPhotoArgs>
    extends StatelessWidget {
  final Arg getPhotoArgs;
  final GetPhotoForObjectWithId getPhotoUseCase;

  final Widget Function(Uint8List bytes) dataBuilder;
  final Widget Function()? emptyBuilder;

  const CachedImageWidget({
    super.key,
    required this.getPhotoArgs,
    required this.dataBuilder,
    required this.getPhotoUseCase,
    this.emptyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey(getPhotoArgs.objectId),
      create: (context) => CachedImageCubit(
        getPhotoArg: getPhotoArgs,
        getClubPhoto: getPhotoUseCase,
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<CachedImageCubit<Arg>, CachedImageState>(
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
