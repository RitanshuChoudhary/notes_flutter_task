import 'package:flutter/material.dart';

class CommonTextfield extends StatelessWidget {
  const CommonTextfield({
    super.key,
    this.node,
    this.title,
    required this.hintText,
    this.minLines,
    this.maxLines,
    this.validator,
    required this.controller,
  });

  final FocusNode? node;
  final String? title;
  final String hintText;
  final int? minLines;
  final int? maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),

        TextFormField(
          controller: controller,
          focusNode: node,
          minLines: minLines ?? 1,
          maxLines: maxLines ?? 1,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          style: theme.textTheme.bodyMedium,

          decoration: InputDecoration(
            filled: true,
            fillColor:
                theme.inputDecorationTheme.fillColor ??
                theme.colorScheme.surface,

            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: (minLines ?? 1) > 1 ? 10 : 0,
            ),

            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),

            border: _border(theme),
            enabledBorder: _border(theme),
            focusedBorder: _border(theme, color: theme.colorScheme.primary),
            errorBorder: _border(theme, color: Colors.red),
            focusedErrorBorder: _border(theme, color: Colors.red),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(ThemeData theme, {Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color ?? theme.dividerColor, width: 0.7),
    );
  }
}
