import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_utils/ui_utils.dart';

import '../logo/logo.dart';

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
    final anyBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: context.colors.base_50,
        width: 1.toFigmaSize,
      ),
      borderRadius: BorderRadius.circular(
        16.toFigmaSize,
      ),
    );
    return SizedBox(
      height: 48.toFigmaSize,
      child: TextField(
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          filled: true,
          fillColor: context.colors.base_0,
          focusedBorder: anyBorder,
          border: anyBorder,
          hintText: widget.hint,
          suffixIconConstraints: BoxConstraints.loose(
            Size(
              (28 + 12).toFigmaSize,
              28.toFigmaSize,
            ),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 12.toFigmaSize),
            child: _SuffixButton(
              controller: controller,
              onLogoTap: widget.onLogoTap,
              onSend: widget.onSend,
            ),
          ),
        ),
      ),
    );
  }
}
