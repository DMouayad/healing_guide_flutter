import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/features/search/models/search_result.dart';
import 'package:healing_guide_flutter/features/theme/app_theme.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

const _baseImagePath = 'assets/images/';

class SearchResultCardContent extends StatelessWidget {
  const SearchResultCardContent(this.result, {super.key});
  final SearchResult result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: Image.asset(
              _baseImagePath + result.avatarImgUrl,
              width: 65,
              height: 65,
              color: context.isDarkMode &&
                      result.category == SearchResultCategory.facility
                  ? AppTheme.lightGreyColor
                  : null,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image),
            ),
          ),
          Expanded(
            flex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.title,
                  style: context.myTxtTheme.titleMedium,
                ),
                const SizedBox(height: 9),
                SizedBox(
                  width: context.screenWidth - (65 + 65),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: context.colorScheme.primary,
                        size: 20,
                      ),
                      Text(
                        result.location,
                        style: context.myTxtTheme.bodySmall,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppTheme.yellowColor,
                            size: 20,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            result.stars.toStringAsPrecision(1),
                            style: context.myTxtTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
