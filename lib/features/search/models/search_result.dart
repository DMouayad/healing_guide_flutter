import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:healing_guide_flutter/features/medical_facility/models.dart';
import 'package:healing_guide_flutter/features/physician/models.dart';
import 'package:healing_guide_flutter/utils/src/constants.dart';

typedef SearchResults = Future<List<SearchResult>>;

enum SearchResultCategory { physician, facility }

sealed class SearchResult<T> extends Equatable {
  final T item;
  final String title;
  final String subTitle;
  final String location;
  final double stars;
  final String avatarImgUrl;
  final SearchResultCategory category;

  const SearchResult({
    required this.item,
    required this.category,
    required this.title,
    required this.subTitle,
    required this.location,
    required this.stars,
    required this.avatarImgUrl,
  });

  static SearchResult<Physician> physician(Physician physician) {
    return _PhysicianSearchResult._(physician);
  }

  static SearchResult<MedicalFacility> facility(MedicalFacility facility) {
    return _MedicalFacilitySearchResult._(facility);
  }

  @override
  List<Object?> get props =>
      [item, title, category, subTitle, location, stars, avatarImgUrl];
}

class _MedicalFacilitySearchResult extends SearchResult<MedicalFacility> {
  final MedicalFacility facility;
  _MedicalFacilitySearchResult._(this.facility)
      : super(
          item: facility,
          category: SearchResultCategory.facility,
          title: facility.name,
          subTitle: facility.description,
          location: facility.location,
          stars: facility.rating,
          avatarImgUrl: kDefaultMedicalFacilityAvatarUrl,
        );
}

class _PhysicianSearchResult extends SearchResult<Physician> {
  final Physician physician;
  _PhysicianSearchResult._(this.physician)
      : super(
          item: physician,
          category: SearchResultCategory.physician,
          title: physician.name,
          subTitle: physician.specialties.join(", "),
          location: physician.location,
          stars: physician.rating,
          avatarImgUrl: physician.isMale
              ? kMalePhysicianAvatarUrl
              : kFemalePhysicianAvatarUrl,
        );
}
