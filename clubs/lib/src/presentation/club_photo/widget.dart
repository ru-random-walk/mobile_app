import 'package:clubs/src/presentation/club_photo/logic/cubit/club_photo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_utils/ui_utils.dart';

final photoSize = 32.toFigmaSize;

class ClubPhotoWidget extends StatelessWidget {
  final String clubId;
  final int photoVersion;

  const ClubPhotoWidget({
    super.key,
    required this.clubId,
    required this.photoVersion,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClubPhotoCubit(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<ClubPhotoCubit, ClubPhotoState>(
            builder: (context, state) {
              return switch (state) {
                ClubPhotoLoading _ => _buildPlaceholder(
                    const CircularProgressIndicator.adaptive(),
                  ),
                ClubPhotoError _ => _buildPlaceholder(
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
                final ClubPhotoData data => CircleAvatar(
                    radius: photoSize,
                    foregroundImage: MemoryImage(data.file),
                  ),
              };
            },
          );
        },
      ),
    );
  }

  Widget _buildPlaceholder(Widget child) {
    return SizedBox.square(
      dimension: photoSize,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
