import 'package:flutter/material.dart';

class UserAvatarWidget extends StatelessWidget {
  final Widget avatar;
  final double size;

  const UserAvatarWidget({
    super.key,
    required this.avatar,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: avatar,
      ),
    );
  }
}
