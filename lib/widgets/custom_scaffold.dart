import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.loadingBarrierText,
    this.bodyPadding,
    this.appBarActions,
    this.title,
    required this.showLoadingBarrier,
    required this.body,
  });
  final String? loadingBarrierText;
  final bool showLoadingBarrier;
  final Widget body;
  final EdgeInsets? bodyPadding;
  final List<Widget>? appBarActions;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: context.colorScheme.surface,
          appBar: context.canPop()
              ? AppBar(
                  backgroundColor: context.colorScheme.surface,
                  surfaceTintColor: context.colorScheme.surface,
                  actions: appBarActions,
                  title: title != null ? Text(title!) : null,
                  centerTitle: true,
                )
              : null,
          body: SafeArea(
            child: Padding(
              padding: bodyPadding ?? const EdgeInsets.all(12),
              child: body,
            ),
          ),
        ),
        Visibility(
          visible: showLoadingBarrier,
          child: _LoadingBarrier(text: loadingBarrierText),
        ),
      ],
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
    return Material(
      type: MaterialType.transparency,
      child: Container(
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
      ),
    );
  }
}
