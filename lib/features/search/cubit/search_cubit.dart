import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:healing_guide_flutter/exceptions/app_exception.dart';
import 'package:healing_guide_flutter/features/search/models/search_filters.dart';
import 'package:healing_guide_flutter/features/search/models/search_result.dart';
import 'package:healing_guide_flutter/features/search/repositories.dart';

part 'search_state.dart';

const _initialState =
    SearchState(searchTerm: null, isBusy: false, isEditingFilters: false);

class SearchCubit extends Cubit<SearchState> {
  SearchRepository get _searchRepository => GetIt.I.get();
  SearchCubit({SearchState initialState = _initialState}) : super(initialState);

  void _fetchResults() {
    if (state.searchTerm?.isEmpty ?? true) {
      return;
    }
    emit(state.copyWith(isBusy: true));
    _searchRepository
        .searchFor(state.searchTerm!, state.filters)
        .then(
            (results) => emit(state.copyWith(isBusy: false, results: results)))
        .catchError((error) {
      emit(SearchErrorState(appException: error, searchTerm: state.searchTerm));
    });
  }

  void searchFor(String searchTerm) {
    if (searchTerm != state.searchTerm) {
      emit(state.copyWith(searchTerm: searchTerm));
      _fetchResults();
    }
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

  void onEnterEditingFilters() {
    emit(state.copyWith(isEditingFilters: true));
  }

  void onExitEditingFilters() {
    emit(state.copyWith(isEditingFilters: false));
  }
}
