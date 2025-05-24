import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

part 'widgets/app_bar.dart';
part 'widgets/editable_block.dart';
part 'widgets/body.dart';

class EditUserInfoPage extends StatefulWidget {
  final DetailedUserEntity profile;

  const EditUserInfoPage({super.key, required this.profile});

  @override
  State<EditUserInfoPage> createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: const _EditUserAppBarWidget(),
          body: _EditUserInfoBodyWidget(widget.profile),
        ),
      ),
    );
  }
}
