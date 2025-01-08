import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_utils/ui_utils.dart';

import '../logo/logo.dart';
import 'text_field.dart';

part 'logo_button.dart';
part 'send_button.dart';
part 'suffix_button.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String hint;
  final VoidCallback? onSend;
  final VoidCallback? onLogoTap;

  const InputWidget({
    super.key,
    this.controller,
    this.hint = '',
    this.onSend,
    this.onLogoTap,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final suffix = Padding(
      padding: EdgeInsets.only(right: 12.toFigmaSize),
      child: _SuffixButton(
        controller: controller,
        onLogoTap: widget.onLogoTap,
        onSend: widget.onSend,
      ),
    );
    return CustomTextField(
      height: 48.toFigmaSize,
      controller: controller,
      hint: widget.hint,
      suffix: suffix,
    );
  }
}
