import 'package:flutter/material.dart';
import 'package:todo/constants/color.dart';

class Text_Field extends StatelessWidget {
  final String hint_text;
  final IconData? icon;
  final void Function()? onTap;
  final bool readOnly;
  final void Function(String)? onChanged;
  final TextEditingController? textEditingController;

  Text_Field({
    super.key,
    required this.hint_text,
    this.icon,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: primary),
      readOnly: readOnly,
      onChanged: onChanged,
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hint_text,
          suffixIcon: InkWell(
            onTap: onTap,
            child: Icon(
              icon,
              color: primary,
            ),
          ),
          hintStyle: const TextStyle(color: primary)),
    );
  }
}
