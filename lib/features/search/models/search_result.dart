import 'dart:async';

import 'package:equatable/equatable.dart';

typedef SearchResults = Future<List<SearchResult>>;

enum SearchResultCategory { physician, facility }

class SearchResult extends Equatable {
  final String resourceId;
  final String title;
  final String subTitle;
  final String location;
  final double stars;
  final String avatarImgUrl;
  final SearchResultCategory category;

  const SearchResult({
    required this.resourceId,
    required this.category,
    required this.title,
    required this.subTitle,
    required this.location,
    required this.stars,
    required this.avatarImgUrl,
  });
  @override
  List<Object?> get props =>
      [resourceId, title, category, subTitle, location, stars, avatarImgUrl];

  Map<String, dynamic> toJson() {
    return {
      "resourceId": resourceId,
      "title": title,
      "subTitle": subTitle,
      "location": location,
      "category": category.name,
      "stars": stars,
      "avatarImgUrl": avatarImgUrl,
    };
  }

  static SearchResult? fromJson(Map<String, dynamic> json) {
    if (json
        case ({
          "resourceId": String resourceId,
          "title": String title,
          "subtitle": String subTitle,
          "location": String location,
          "category": String category,
          "stars": double stars,
          "avatarImgUrl": String avatarImgUrl,
        })) {
      return SearchResult(
        resourceId: resourceId,
        category: SearchResultCategory.values.byName(category),
        title: title,
        subTitle: subTitle,
        location: location,
        stars: stars,
        avatarImgUrl: avatarImgUrl,
      );
    }
    return null;
  }
}
