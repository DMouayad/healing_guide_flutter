import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class HomeScreenSection extends StatelessWidget {
  const HomeScreenSection({super.key, required this.title, this.onViewAll});
  final String title;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OverflowBar(
          alignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.myTxtTheme.titleMedium
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            if (onViewAll != null)
              TextButton(
                onPressed: onViewAll,
                child: Text(context.l10n.viewAllBtnLabel),
              ),
          ],
        ),
      ],
    );
  }
}
