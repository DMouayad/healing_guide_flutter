import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/features/search/models/search_filters.dart';
import 'package:healing_guide_flutter/features/search/models/search_result.dart';

part 'search_state.dart';

const _initialState =
    SearchState(searchTerm: null, isBusy: false, isEditingFilters: false);

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({SearchState initialState = _initialState}) : super(initialState);
  void _fetchResults() {
    if (state.searchTerm?.isEmpty ?? true) {
      return;
    }
    emit(state.copyWith(isBusy: true));
    print('searching for "${state.searchTerm}"');
    Timer(
      const Duration(seconds: 2),
      () => emit(state.copyWith(isBusy: false)),
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

  SearchCubit fromJson(Map<String, dynamic> json) {
    SearchState? initialState;
    if (json case ({"state": Map<String, dynamic> stateJson})) {
      initialState = SearchState.fromJson(stateJson);
    }
    return SearchCubit(initialState: initialState ?? _initialState);
  }

  Map<String, dynamic>? toJson() {
    return {
      "state": state.toJson(),
    };
  }

  void onEditingFilters(bool isEditingMode) {
    emit(state.copyWith(isEditingFilters: isEditingMode));
  }
}
