import 'package:clubs/src/presentation/club_photo/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

class ClubWidget extends StatelessWidget {
  final String clubId;
  final int photoVersion;
  final String title;
  final String subscribers;
  final String image;
  final void Function()? onTap;

  const ClubWidget({
    super.key,
    required this.title,
    required this.subscribers,
    this.image = 'packages/clubs/assets/images/avatar.png',
    this.onTap,
    required this.clubId,
    required this.photoVersion,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.toFigmaSize,
            color: context.colors.base_20,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.toFigmaSize,
          bottom: 12.toFigmaSize,
          left: 4.toFigmaSize,
          right: 4.toFigmaSize,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClubPhotoListWidget(
              clubId: clubId,
              photoVersion: photoVersion,
            ),
            SizedBox(width: 16.toFigmaSize),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.h5
                        .copyWith(color: context.colors.base_90),
                  ),
                  SizedBox(height: 4.toFigmaSize),
                  Text(
                    subscribers,
                    style: context.textTheme.bodyMRegularBase70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
