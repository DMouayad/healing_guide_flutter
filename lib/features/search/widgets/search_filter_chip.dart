import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/features/theme/app_theme.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class SearchFilterChip extends StatelessWidget {
  const SearchFilterChip({
    super.key,
    this.label,
    this.onDeleted,
    this.avatarIcon,
    required this.value,
  }) : assert(value != null || label != null);
  final String? label;
  final IconData? avatarIcon;
  final String? value;
  final void Function()? onDeleted;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label != null ? '$label ${value != null ? ': $value' : ''}' : value!,
      ),
      labelStyle: context.myTxtTheme.bodyMedium,
      avatar: avatarIcon != null ? Icon(avatarIcon) : null,
      avatarBoxConstraints: const BoxConstraints(maxWidth: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: value != null
              ? context.colorScheme.onSurface
              : AppTheme.lightGreyColor,
        ),
      ),
      onDeleted: value != null ? onDeleted : null,
    );
  }
}
