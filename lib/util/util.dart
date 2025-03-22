import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

bool isDarkTheme(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}
