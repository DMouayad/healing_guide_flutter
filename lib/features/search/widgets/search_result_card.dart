import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/features/search/models/search_result.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard(this.result, {super.key});
  final SearchResult result;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: context.colorScheme.inverseSurface,
      ),
    );
  }
}
