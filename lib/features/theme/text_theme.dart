import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

import 'app_theme.dart';

class MyTextTheme {
  final BuildContext context;

  factory MyTextTheme.of(BuildContext context) {
    return MyTextTheme._(context);
  }

  MyTextTheme._(this.context);

  TextStyle get displayLarge =>
      TextStyle(fontSize: context.textTheme.displayLarge?.fontSize);

  TextStyle get displayMedium =>
      TextStyle(fontSize: context.textTheme.displayMedium?.fontSize);

  TextStyle get displaySmall =>
      TextStyle(fontSize: context.textTheme.displaySmall?.fontSize);

  TextStyle get titleLarge =>
      TextStyle(fontSize: context.textTheme.titleLarge?.fontSize);

  TextStyle get titleMedium =>
      TextStyle(fontSize: context.textTheme.titleMedium?.fontSize);

  TextStyle get titleSmall =>
      TextStyle(fontSize: context.textTheme.titleSmall?.fontSize);

  TextStyle get bodyLarge => TextStyle(
        fontSize: context.textTheme.bodyLarge?.fontSize,
        color: AppTheme.secondaryTextColor,
      );

  TextStyle get bodyMedium => TextStyle(
        fontSize: context.textTheme.bodyMedium?.fontSize,
        color: AppTheme.secondaryTextColor,
        fontFamily: AppTheme.kFontFamily,
      );

  TextStyle get bodySmall => TextStyle(
        fontSize: context.textTheme.bodySmall?.fontSize,
        color: AppTheme.secondaryTextColor,
        fontFamily: AppTheme.kFontFamily,
      );
}
