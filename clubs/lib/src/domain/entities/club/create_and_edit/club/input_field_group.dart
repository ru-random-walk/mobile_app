import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';


class TextFieldGroup extends StatelessWidget {
  final int num; 
  final TextEditingController controller; 
  final String title; 

  const TextFieldGroup({
    super.key,
    required this.num,
    required this.controller,
    required this.title,
    
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      maxLines: num, 
      radius: 6.toFigmaSize, 
      controller: controller, 
      height: 36.toFigmaSize, 
      hint: title, 
      textStyle: context.textTheme.bodyMRegularBase90, 
    );
  }
}
