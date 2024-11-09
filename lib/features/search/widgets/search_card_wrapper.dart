import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/features/search/models/search_result.dart';
import 'package:healing_guide_flutter/features/search/widgets/search_result_card.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class SearchCardWrapper extends StatelessWidget {
  const SearchCardWrapper({
    super.key,
    required this.onTap,
    required this.result,
  });
  final SearchResult result;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: context.colorScheme.inversePrimary,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(
                  237, 238, 251, context.isDarkMode ? 0.1 : 0.75),
              offset: const Offset(0, 5),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onTap,
          child: SearchResultCardContent(result),
        ),
      ),
    );
  }
}
