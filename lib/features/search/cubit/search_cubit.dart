import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/search/models/search_filters.dart';
import 'package:healing_guide_flutter/features/search/models/search_result.dart';
import 'package:healing_guide_flutter/features/search/repositories.dart';
import 'package:healing_guide_flutter/utils/src/bloc_helpers.dart';

part 'search_state.dart';

const _initialState =
    SearchState(searchTerm: null, isBusy: false, isEditingFilters: false);

class SearchCubit extends Cubit<SearchState> {
  SearchRepository get _searchRepository => GetIt.I.get();
  late final BlocHelpers _helpers;
  SearchCubit({SearchState initialState = _initialState})
      : super(initialState) {
    _helpers = BlocHelpers(
      onError: (exception) => emit(SearchFailureState(
        exception,
        searchTerm: state.searchTerm,
        filters: state.filters,
        results: state.results,
      )),
      setBusyTrue: () => emit(state.copyWith(isBusy: true)),
      setBusyFalse: () => emit(state.copyWith(isBusy: false)),
      isBusy: () => state.isBusy,
    );
  }

  void _fetchResults() {
    if (state.searchTerm?.isEmpty ?? true) {
      return;
    }
    _helpers.handleFuture(
      _searchRepository.searchFor(state.searchTerm!, state.filters),
      onSuccess: (results) =>
          emit(state.copyWith(isBusy: false, results: results)),
    );
  }

  void searchFor(String searchTerm) {
    emit(state.copyWith(searchTerm: searchTerm));
    _fetchResults();
  }

  void setSearchCategory(SearchCategoryFilter categoryFilter) {
    emit(state.copyWith(
      filters: state.filters.copyWith(categoryFilter: categoryFilter),
    ));
    _fetchResults();
  }

  void applyFilters(SearchFilters filters) {
    emit(state.copyWith(filters: filters, isEditingFilters: false));
    _fetchResults();
  }

  void onEnterEditingFilters() {
    emit(state.copyWith(isEditingFilters: true));
  }

  void onExitEditingFilters() {
    emit(state.copyWith(isEditingFilters: false));
  }
}
