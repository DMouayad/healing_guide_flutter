import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class LoadingBarrier extends StatelessWidget {
  const LoadingBarrier({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    final textColor = context.isDarkMode
        ? context.colorScheme.onSurface
        : context.colorScheme.onInverseSurface;
    return Container(
      color: context.isDarkMode
          ? context.colorScheme.surface.withOpacity(.81)
          : context.colorScheme.inverseSurface.withOpacity(.81),
      child: GestureDetector(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text ?? context.l10n.loadingBarrierDefaultText,
                style: context.myTxtTheme.titleLarge.copyWith(
                  color: textColor,
                ),
              ),
              const SizedBox(height: 24),
              CircularProgressIndicator(color: textColor),
            ],
          ),
        ),
      ),
    );
  }
}
