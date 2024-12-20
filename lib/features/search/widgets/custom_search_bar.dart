import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healing_guide_flutter/features/search/cubit/search_cubit.dart';
import 'package:healing_guide_flutter/features/theme/app_theme.dart';
import 'package:healing_guide_flutter/routes/routes.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class FakeSearchBar extends StatelessWidget {
  const FakeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => const SearchScreenRoute().push(context),
      child: Hero(
        tag: const Key('CustomSearchBar_Hero_Tag'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0),
          child: Material(
            type: MaterialType.transparency,
            child: TextFormField(
              enabled: false,
              canRequestFocus: false,
              // onTap: () => const SearchScreenRoute().push(context),
              decoration: InputDecoration(
                filled: true,
                isDense: false,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide:
                      const BorderSide(width: 2, color: Colors.transparent),
                ),
                fillColor: context.colorScheme.surface,
                hintText: context.l10n.homeSearchBarHint,
                hintStyle: context.myTxtTheme.bodySmall,
                prefixIcon: const Icon(Icons.search_outlined),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: const BorderSide(width: 2, color: AppTheme.lightGreyColor),
    );
    final cubit = context.read<SearchCubit>();
    return Hero(
      tag: const Key('CustomSearchBar_Hero_Tag'),
      child: Material(
        type: MaterialType.transparency,
        child: BlocBuilder<SearchCubit, SearchState>(
          buildWhen: (prev, current) =>
              (prev.isBusy != current.isBusy) ||
              (prev.isEditingFilters != current.isEditingFilters),
          builder: (context, state) {
            return ExcludeFocus(
              excluding: state.isEditingFilters,
              child: TextFormField(
                initialValue: state.searchTerm,
                onFieldSubmitted: (value) => cubit.searchFor(value),
                autofocus: true,
                enabled: !state.isBusy,
                decoration: InputDecoration(
                  filled: true,
                  isDense: false,
                  enabledBorder: baseBorder,
                  border: baseBorder,
                  focusedBorder: baseBorder.copyWith(
                      borderSide: BorderSide(
                          color: context.colorScheme.primary, width: 2)),
                  fillColor: context.colorScheme.surface,
                  hintText: context.l10n.homeSearchBarHint,
                  hintStyle: context.myTxtTheme.bodySmall,
                  prefixIcon: const Icon(Icons.search_outlined),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  suffixIcon: IconButton(
                    onPressed: state.isEditingFilters
                        ? cubit.onExitEditingFilters
                        : cubit.onEnterEditingFilters,
                    iconSize: 26,
                    icon: Icon(
                      state.isEditingFilters
                          ? Icons.filter_alt_off_outlined
                          : Icons.filter_alt_outlined,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
