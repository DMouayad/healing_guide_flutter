part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    this.results = const [],
    this.filters = const SearchFilters(),
    required this.searchTerm,
    required this.isBusy,
    required this.isEditingFilters,
  });

  final String? searchTerm;
  final SearchFilters filters;
  final bool isBusy;
  final List<SearchResult> results;
  final bool isEditingFilters;
  @override
  List<Object?> get props =>
      [searchTerm, isBusy, results, filters, isEditingFilters];

  SearchState copyWith({
    String? searchTerm,
    bool? isBusy,
    bool? isEditingFilters,
    List<SearchResult>? results,
    SearchFilters? filters,
  }) {
    return SearchState(
      searchTerm: searchTerm ?? this.searchTerm,
      isBusy: isBusy ?? this.isBusy,
      isEditingFilters: isEditingFilters ?? this.isEditingFilters,
      results: results ?? this.results,
      filters: filters ?? this.filters,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isBusy": isBusy,
      "isEditingFilters": isEditingFilters,
      "searchTerm": searchTerm,
      "results": jsonEncode(results.map((el) => el.toJson()).toList()),
      "filters": filters.toJson(),
    };
  }

  static SearchState? fromJson(Map<String, dynamic>? json) {
    if (json
        case ({
          "searchTerm": String searchTerm,
          "isBusy": bool isBusy,
          "isEditingFilters": bool isEditingFilters,
          "results": String resultsJson,
          "filters": dynamic filtersJson,
        })) {
      var decodedResultsJson = jsonDecode(resultsJson);
      final List<SearchResult> results =
          decodedResultsJson is Iterable<Map<String, dynamic>>
              ? decodedResultsJson
                  .map(SearchResult.fromJson)
                  .where((element) => element != null)
                  .toList()
                  .cast()
              : [];

      return SearchState(
        searchTerm: searchTerm,
        isBusy: isBusy,
        isEditingFilters: isEditingFilters,
        results: results,
        filters: SearchFilters.fromJson(filtersJson) ?? const SearchFilters(),
      );
    }
    return null;
  }
}
