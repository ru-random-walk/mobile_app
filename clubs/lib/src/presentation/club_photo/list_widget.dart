import 'package:clubs/src/presentation/club_photo/widget.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

final photoSize = 32.toFigmaSize;

class ClubPhotoListWidget extends StatelessWidget {
  final String clubId;
  final int photoVersion;

  const ClubPhotoListWidget({
    super.key,
    required this.clubId,
    required this.photoVersion,
  });

  @override
  Widget build(BuildContext context) {
    return ClubPhotoWidget(
      clubId: clubId,
      photoVersion: photoVersion,
      loadingBuilder: () => _buildPlaceholder(
        const CircularProgressIndicator.adaptive(),
      ),
      errorBuilder: () => _buildPlaceholder(
        const Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      ),
      emptyBuilder: () => _buildPlaceholder(
        FittedBox(
          child: Text(
            'Нет фото',
            style: context.textTheme.captionMedium,
          ),
        ),
      ),
      dataBuilder: (bytes) => SizedBox.square(
        dimension: photoSize * 2,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: MemoryImage(
                bytes,
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(Widget child) {
    return SizedBox.square(
      dimension: photoSize * 2,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}
