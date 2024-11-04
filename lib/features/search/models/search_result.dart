import 'package:equatable/equatable.dart';

class SearchResult extends Equatable {
  final String title;
  final String subTitle;
  final String location;
  final int stars;
  final String avatarImgUrl;

  const SearchResult({
    required this.title,
    required this.subTitle,
    required this.location,
    required this.stars,
    required this.avatarImgUrl,
  });
  @override
  List<Object?> get props => [
        title,
        subTitle,
        location,
        stars,
        avatarImgUrl,
      ];

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "subTitle": subTitle,
      "location": location,
      "stars": stars.toString(),
      "avatarImgUrl": avatarImgUrl,
    };
  }

  static SearchResult? fromJson(Map<String, dynamic> json) {
    if (json
        case ({
          "title": String title,
          "subtitle": String subTitle,
          "location": String location,
          "stars": String stars,
          "avatarImgUrl": String avatarImgUrl,
        })) {
      return SearchResult(
        title: title,
        subTitle: subTitle,
        location: location,
        stars: int.tryParse(stars) ?? 0,
        avatarImgUrl: avatarImgUrl,
      );
    }
    return null;
  }
}
