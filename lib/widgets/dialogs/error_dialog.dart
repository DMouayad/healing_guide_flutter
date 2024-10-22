import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

Future<void> showErrorDialog(
  BuildContext context, {
  required String title,
  String? errMessage,
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return ErrorDialog(title: title, content: errMessage);
    },
  );
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, this.content, required this.title});

  final String title;
  final String? content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: context.platformBorderRadius),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Icon(Icons.error, size: 30, color: context.colorScheme.error),
        ],
      ),
      content: content != null ? Text(content!) : null,
      actions: [
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(context.l10n.ok),
        ),
      ],
    );
  }
}
