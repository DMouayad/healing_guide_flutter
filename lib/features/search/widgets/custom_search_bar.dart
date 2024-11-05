import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healing_guide_flutter/features/search/cubit/search_cubit.dart';
import 'package:healing_guide_flutter/features/theme/app_theme.dart';
import 'package:healing_guide_flutter/routes/routes.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.inSearchScreen,
    required this.cubit,
  });
  final bool inSearchScreen;
  final SearchCubit cubit;

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(
          width: 2,
          color: inSearchScreen ? AppTheme.lightGreyColor : Colors.transparent),
    );
    return Hero(
      tag: const Key('CustomSearchBar_Hero_Tag'),
      child: Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: inSearchScreen
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 15.0),
          child: BlocBuilder<SearchCubit, SearchState>(
            bloc: cubit,
            buildWhen: (prev, current) =>
                (prev.isBusy != current.isBusy) ||
                (prev.isEditingFilters != current.isEditingFilters),
            builder: (context, state) {
              return ExcludeFocus(
                excluding: !inSearchScreen || state.isEditingFilters,
                child: TextFormField(
                  initialValue: state.searchTerm,
                  onFieldSubmitted: (value) => cubit.searchFor(value),
                  autofocus: inSearchScreen,
                  enabled: !state.isBusy,
                  onTap: inSearchScreen
                      ? null
                      : () => SearchScreenRoute(context.read()).push(context),
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
                    suffixIcon: !inSearchScreen
                        ? null
                        : IconButton(
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
      ),
    );
  }
}
