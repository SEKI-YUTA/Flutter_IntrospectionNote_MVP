import 'package:flutter/material.dart';
import 'package:introspection_note_mvp/constant/constant.dart';
import 'package:introspection_note_mvp/data/models/modify_form_color_scheme.dart';

bool checkIsDarkTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

// テーマによって適切なカラースキームを返す関数
IntrospectionColor getFormColorScheme(BuildContext context) {
  return checkIsDarkTheme(context)
      ? CreateFormColors.Dark
      : CreateFormColors.Light;
}
