import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/features/search/models/search_result.dart';

import 'search_result_card.dart';

class SearchResultSheet extends StatelessWidget {
  const SearchResultSheet({
    super.key,
    required this.selectedResult,
    required this.scrollController,
  });

  final SearchResult selectedResult;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SearchResultCardContent(selectedResult),
            ],
          ),
        ),
      ),
    );
  }
}
