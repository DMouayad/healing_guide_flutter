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
          ? context.colorScheme.surface.withOpacity(.9)
          : context.colorScheme.inverseSurface.withOpacity(.9),
      child: GestureDetector(
        child: Center(
          child: SizedBox(
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text ?? context.l10n.loadingBarrierDefaultText,
                  textAlign: TextAlign.center,
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
      ),
    );
  }
}
