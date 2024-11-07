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
}

class SearchErrorState extends SearchState {
  const SearchErrorState(
      {required this.appException, required super.searchTerm})
      : super(isBusy: false, isEditingFilters: false);
  final AppException appException;
  @override
  List<Object?> get props => [...super.props, appException];
}
