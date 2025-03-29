import 'dart:ui';

class IntrospectionColor {
  const IntrospectionColor({
    required this.positiveItemsToneColor,
    required this.improvementItemsToneColor,
    required this.dailyCommentToneColor,
    required this.commonToolToneColor,
    required this.dangerToolToneColor,
  });
  final Color positiveItemsToneColor;
  final Color improvementItemsToneColor;
  final Color dailyCommentToneColor;
  final Color commonToolToneColor;
  final Color dangerToolToneColor;
}
