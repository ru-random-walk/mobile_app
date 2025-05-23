import 'package:clubs/src/presentation/club_photo/widget.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class ClubDetailPhotoWidget extends StatelessWidget {
  final String clubId;
  final int photoVersion;

  const ClubDetailPhotoWidget({
    super.key,
    required this.clubId,
    required this.photoVersion,
  });

  @override
  Widget build(BuildContext context) {
    return ClubPhotoWidget(
      clubId: clubId,
      photoVersion: photoVersion,
      emptyBuilder: () => _wrap(
          child: Center(
              child: Text(
        'Нет фото',
        style: context.textTheme.captionMedium,
      ))),
      dataBuilder: (bytes) => _wrap(
        child: Image.memory(
          bytes,
          fit: BoxFit.cover,
        ),
      ),
      size: 240.toFigmaSize,
    );
  }

  Widget _wrap({required Widget child}) {
    return Center(
      child: SizedBox.square(
        dimension: 240.toFigmaSize,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.toFigmaSize),
          child: child,
        ),
      ),
    );
  }
}
