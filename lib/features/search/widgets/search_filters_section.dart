import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healing_guide_flutter/features/search/cubit/search_cubit.dart';
import 'package:healing_guide_flutter/features/search/models/search_filters.dart';
import 'package:healing_guide_flutter/features/search/widgets/search_filter_chip.dart';
import 'package:healing_guide_flutter/features/theme/app_theme.dart';
import 'package:healing_guide_flutter/utils/src/constants.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class SearchFiltersSection extends StatefulWidget {
  const SearchFiltersSection(this.searchCubit, {super.key});
  final SearchCubit searchCubit;

  @override
  State<SearchFiltersSection> createState() => _SearchFilterStatesSection();
}

class _SearchFilterStatesSection extends State<SearchFiltersSection> {
  SearchFilters filters = const SearchFilters();

  @override
  void initState() {
    filters = widget.searchCubit.state.filters;
    super.initState();
  }

  void setCategoryFilter(SearchCategoryFilter category) {
    setState(() => filters = filters.copyWith(categoryFilter: category));
  }

  void setCityFilter(String? cityName) {
    setState(() {
      filters = filters.copyWith(
          cityFilter: cityName != null
              ? SearchFilter.cityFilter(filterValue: cityName)
              : null);
    });
  }

  void setSpecialtyFilter(String? specialty) {
    setState(() {
      filters = filters.copyWith(
          specialtyFilter: specialty != null
              ? SearchFilter.specialtyFilter(filterValue: specialty)
              : null);
    });
  }

  void clearCityFilter() {
    setState(() {
      filters = SearchFilters(specialtyFilter: filters.specialtyFilter);
    });
  }

  void clearSpecialtyFilter() {
    setState(() {
      filters = SearchFilters(cityFilter: filters.cityFilter);
    });
  }

  List<PopupMenuEntry<T>> getItems<T>(
      List<T> values, String Function(T item) getItemText) {
    return values
        .map((e) => PopupMenuItem(value: e, child: Text(getItemText(e))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final border = RoundedRectangleBorder(
      side: BorderSide(color: context.colorScheme.onSurface),
      borderRadius: BorderRadius.circular(6),
    );
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (prev, current) =>
          (prev.isEditingFilters != current.isEditingFilters) ||
          (prev.filters != current.filters),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: OverflowBar(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (state.isEditingFilters) ...[
                    TextButton(
                      onPressed: widget.searchCubit.onExitEditingFilters,
                      child: Text(context.l10n.cancel),
                    ),
                    FilledButton(
                      onPressed: state.filters != filters
                          ? () => widget.searchCubit.applyFilters(filters)
                          : null,
                      child: Text(context.l10n.applyFilters),
                    ),
                  ] else ...[
                    Text(
                      context.l10n.searchFiltersSectionTitle,
                      style: context.myTxtTheme.bodySmall,
                    )
                  ],
                ],
              ),
              AnimatedCrossFade(
                firstChild: Wrap(
                  spacing: 3,
                  children: [
                    _FilterInfoChip(
                      label: context.l10n.categorySearchFilterPopupLabel,
                      value: state.filters.categoryFilter.getMessage(context),
                      filterEnabled: true,
                    ),
                    _FilterInfoChip(
                      filterEnabled: state.filters.cityFilter != null,
                      value: state.filters.cityFilter?.filterValue,
                      label: context.l10n.citySearchFilterPopupLabel,
                    ),
                    if (state.filters.categoryFilter !=
                        SearchCategoryFilter.facilities)
                      _FilterInfoChip(
                        filterEnabled: state.filters.specialtyFilter != null,
                        value: state.filters.specialtyFilter?.filterValue,
                        label: context.l10n.specialtySearchFilterPopupLabel,
                      ),
                  ],
                ),
                secondChild: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 10,
                    runSpacing: 5,
                    children: [
                      PopupMenuButton(
                        elevation: 1,
                        shape: border,
                        initialValue: filters.categoryFilter,
                        onSelected: setCategoryFilter,
                        itemBuilder: (context) => getItems(
                          SearchCategoryFilter.values,
                          (e) => e.getMessage(context),
                        ),
                        child: SearchFilterChip(
                          avatarIcon: Icons.filter_alt_outlined,
                          label: context.l10n.categorySearchFilterPopupLabel,
                          value: filters.categoryFilter.getMessage(context),
                        ),
                      ),
                      PopupMenuButton<String>(
                        elevation: 1,
                        shape: border,
                        initialValue: filters.cityFilter?.filterValue,
                        onSelected: setCityFilter,
                        itemBuilder: (context) => getItems(kCities, (e) => e),
                        child: SearchFilterChip(
                          avatarIcon: Icons.location_city,
                          onDeleted: clearCityFilter,
                          value: filters.cityFilter?.filterValue,
                          label: context.l10n.citySearchFilterPopupLabel,
                        ),
                      ),
                      if (filters.categoryFilter !=
                          SearchCategoryFilter.facilities)
                        PopupMenuButton<String>(
                          elevation: 1,
                          shape: border,
                          initialValue: filters.specialtyFilter?.filterValue,
                          onSelected: setSpecialtyFilter,
                          itemBuilder: (context) =>
                              getItems(kMedicalSpecialties.toList(), (e) => e),
                          child: SearchFilterChip(
                            avatarIcon: Icons.medical_services,
                            onDeleted: clearSpecialtyFilter,
                            value: filters.specialtyFilter?.filterValue,
                            label: context.l10n.specialtySearchFilterPopupLabel,
                          ),
                        ),
                      const Divider(),
                    ],
                  ),
                ),
                crossFadeState: state.isEditingFilters
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 500),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterInfoChip extends StatelessWidget {
  const _FilterInfoChip(
      {required this.label, required this.filterEnabled, this.value});
  final String label;
  final String? value;
  final bool filterEnabled;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: EdgeInsets.zero,
      label: Text('$label: ${value ?? context.l10n.allSearchFilter}'),
      labelStyle: context.myTxtTheme.bodySmall
          .copyWith(color: context.colorScheme.onSurface),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: filterEnabled
              ? context.colorScheme.onSurface
              : AppTheme.lightGreyColor,
        ),
      ),
    );
  }
}
