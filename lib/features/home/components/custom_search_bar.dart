import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ExcludeFocus(
        child: SearchAnchor.bar(
          barHintText: context.l10n.homeSearchBarHint,
          barHintStyle: WidgetStatePropertyAll(context.myTxtTheme.bodySmall),
          barElevation: const WidgetStatePropertyAll(0),
          barShape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          suggestionsBuilder: (context, controller) => [],
        ),
      ),
    );
  }
}
