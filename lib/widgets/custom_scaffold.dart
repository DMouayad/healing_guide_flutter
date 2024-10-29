import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.loadingBarrierText,
    required this.showLoadingBarrier,
    required this.body,
    this.bodyPadding,
  });
  final String? loadingBarrierText;
  final bool showLoadingBarrier;
  final Widget body;
  final EdgeInsets? bodyPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: bodyPadding ?? const EdgeInsets.all(12),
              child: body,
            ),
            Visibility(
              visible: showLoadingBarrier,
              child: _LoadingBarrier(text: loadingBarrierText),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingBarrier extends StatelessWidget {
  const _LoadingBarrier({this.text});
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