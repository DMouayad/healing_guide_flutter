import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

enum SearchCategoryFilter {
  all,
  doctors,
  facilities;

  String getMessage(BuildContext context) {
    return switch (this) {
      SearchCategoryFilter.doctors => context.l10n.doctorSearchFilter,
      SearchCategoryFilter.facilities => context.l10n.facilitySearchFilter,
      SearchCategoryFilter.all => context.l10n.allSearchFilter,
    };
  }
}

final class SearchFilters extends Equatable {
  final SearchFilter? cityFilter;
  final SearchFilter? specialtyFilter;
  final SearchCategoryFilter categoryFilter;

  const SearchFilters({
    this.cityFilter,
    this.specialtyFilter,
    this.categoryFilter = SearchCategoryFilter.all,
  });
  SearchFilters copyWith({
    SearchFilter? cityFilter,
    SearchFilter? specialtyFilter,
    SearchCategoryFilter? categoryFilter,
  }) {
    return SearchFilters(
      cityFilter: cityFilter ?? this.cityFilter,
      specialtyFilter: specialtyFilter ?? this.specialtyFilter,
      categoryFilter: categoryFilter ?? this.categoryFilter,
    );
  }

  @override
  List<Object?> get props => [cityFilter, specialtyFilter, categoryFilter];

  static SearchFilters? fromJson(Map<String, dynamic>? json) {
    SearchFilter? cityFilter;
    SearchFilter? specialtyFilter;

    if (json?['cityFilter'] case (Map<String, dynamic> city)) {
      cityFilter = SearchFilter.fromJson(city);
    }
    if (json?['specialtyFilter'] case (Map<String, dynamic> specialty)) {
      specialtyFilter = SearchFilter.fromJson(specialty);
    }

    var categoryFilter = SearchCategoryFilter.all;
    if (json?['categoryFilter'] case String categoryFilterName) {
      if (SearchCategoryFilter.values
          .asNameMap()
          .keys
          .contains(categoryFilterName)) {
        categoryFilter = SearchCategoryFilter.values.byName(categoryFilterName);
      }
    }
    return SearchFilters(
      cityFilter: cityFilter,
      specialtyFilter: specialtyFilter,
      categoryFilter: categoryFilter,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (cityFilter != null) "cityFilter": cityFilter?.toJson(),
      if (specialtyFilter != null) "specialtyFilter": specialtyFilter?.toJson(),
      "categoryFilter": categoryFilter.name,
    };
  }
}

final class SearchFilter extends Equatable {
  final String filterValue;
  final String filterName;
  final bool asc;

  const SearchFilter._({
    required this.filterValue,
    required this.filterName,
    required this.asc,
  });
  static const cityFilterValue = 'city';
  static const specialtyFilterValue = 'specialty';

  factory SearchFilter.specialtyFilter(
      {required String filterValue, bool asc = true}) {
    return SearchFilter._(
        filterValue: filterValue, filterName: specialtyFilterValue, asc: asc);
  }

  factory SearchFilter.cityFilter(
      {required String filterValue, bool asc = true}) {
    return SearchFilter._(
        filterValue: filterValue, filterName: cityFilterValue, asc: asc);
  }

  Map<String, dynamic> toJson() {
    return {
      "filterValue": filterValue,
      "filterName": filterName,
      "asc": asc,
    };
  }

  static SearchFilter? fromJson(Map<String, dynamic>? json) {
    if (json
        case ({
          "filterName": String filterName,
          "filterValue": String filterValue,
          "asc": bool asc,
        })) {
      return SearchFilter._(
          filterValue: filterValue, filterName: filterName, asc: asc);
    }
    return null;
  }

  @override
  List<Object?> get props => [filterName, filterValue, asc];
}
