import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

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
}
