import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/features/search/cubit/search_cubit.dart';
import 'package:healing_guide_flutter/features/search/widgets/search_filters_section.dart';
import 'package:healing_guide_flutter/features/search/widgets/custom_search_bar.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:healing_guide_flutter/widgets/custom_scaffold.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.searchCubit});
  final SearchCubit searchCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: searchCubit,
      child: Builder(builder: (context) {
        return CustomScaffold(
          showLoadingBarrier: false,
          title: context.l10n.searchScreenTitle,
          bodyPadding: const EdgeInsets.all(15),
          body: CustomScrollView(
            slivers: [
              PinnedHeaderSliver(
                child: Column(
                  children: [
                    CustomSearchBar(inSearchScreen: true, cubit: searchCubit),
                    const SizedBox(height: 15),
                    SearchFiltersSection(searchCubit),
                  ],
                ),
              ),
              BlocBuilder<SearchCubit, SearchState>(
                buildWhen: (prev, current) =>
                    (prev.isBusy != current.isBusy) ||
                    prev.results != current.results,
                builder: (context, state) {
                  return SliverFillRemaining(
                    child: state.isBusy
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox.square(
                                dimension: 50,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 3,
                                ),
                              ),
                            ],
                          )
                        : ListView(),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
