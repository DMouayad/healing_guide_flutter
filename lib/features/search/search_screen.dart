import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/features/search/cubit/search_cubit.dart';
import 'package:healing_guide_flutter/features/search/models/search_result.dart';
import 'package:healing_guide_flutter/features/search/widgets/search_card_wrapper.dart';
import 'package:healing_guide_flutter/features/search/widgets/search_filters_section.dart';
import 'package:healing_guide_flutter/features/search/widgets/custom_search_bar.dart';
import 'package:healing_guide_flutter/utils/utils.dart';
import 'package:healing_guide_flutter/widgets/custom_scaffold.dart';

import 'widgets/search_result_sheet.dart';

const _fetchFullInfoMinSheetHeightExtent = 0.9;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchCubit});
  final SearchCubit searchCubit;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final sheetController = DraggableScrollableController();
  final ValueNotifier<double> _opacityNotifier = ValueNotifier(1.0);
  var initialChildSize = .7;
  bool sheetIsOpening = false;
  @override
  void initState() {
    sheetController.addListener(() {
      // Update opacity based on scroll offset
      if (!sheetIsOpening && sheetController.size < .2) {
        double opacity = sheetController.size;
        _opacityNotifier.value = opacity;
      }
    });
    super.initState();
  }

  SearchResult? selectedResult;

  Future<void> hideSheet() async {
    if (selectedResult == null) {
      return;
    }

    selectedResult = null;
    await sheetController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
    setState(() {});
    _opacityNotifier.value = 1;
  }

  Future<void> showSheet(SearchResult result) async {
    sheetIsOpening = true;
    setState(() {
      selectedResult = result;
    });
    await Future.delayed(const Duration(milliseconds: 50));
    await sheetController.animateTo(
      initialChildSize,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
    sheetIsOpening = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.searchCubit,
      child: Builder(
        builder: (context) {
          return Stack(
            children: [
              CustomScaffold(
                showLoadingBarrier: false,
                title: context.l10n.searchScreenTitle,
                bodyPadding: const EdgeInsets.all(15),
                body: CustomScrollView(
                  slivers: [
                    PinnedHeaderSliver(
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.surface,
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(6)),
                        ),
                        child: Column(
                          children: [
                            CustomSearchBar(
                                inSearchScreen: true,
                                cubit: widget.searchCubit),
                            SearchFiltersSection(widget.searchCubit),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<SearchCubit, SearchState>(
                      buildWhen: (prev, current) =>
                          (prev.isBusy != current.isBusy) ||
                          prev.results != current.results,
                      builder: (context, state) {
                        return SliverFillRemaining(
                          fillOverscroll: true,
                          hasScrollBody: false,
                          child: state.isBusy
                              ? const Center(
                                  child: SizedBox.square(
                                    dimension: 50,
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 3,
                                    ),
                                  ),
                                )
                              : Column(
                                  children: state.results.map((e) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: SearchCardWrapper(
                                        result: e,
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          showSheet(e);
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (selectedResult != null) ...[
                Positioned.fill(
                  child: GestureDetector(
                    onTap: hideSheet,
                    child: ValueListenableBuilder(
                      valueListenable: _opacityNotifier,
                      builder: (context, value, child) {
                        return Container(
                          color: Colors.black.withOpacity(value * .4),
                        );
                      },
                    ),
                  ),
                ),
                Positioned.fill(
                  child: NotificationListener<DraggableScrollableNotification>(
                    onNotification: (notification) {
                      if (notification.extent <= notification.minExtent) {
                        hideSheet();
                      }
                      if (notification.extent >
                          _fetchFullInfoMinSheetHeightExtent) {
                        //TODO: fetch full profile info
                        print('fetch full profile info');
                      }
                      return true;
                    },
                    child: DraggableScrollableSheet(
                      shouldCloseOnMinExtent: true,
                      maxChildSize: 1,
                      minChildSize: 0,
                      initialChildSize: 0.1,
                      controller: sheetController,
                      snapSizes: const [0.7],
                      snap: true,
                      builder: (context, scrollController) {
                        return SearchResultSheet(
                          selectedResult: selectedResult!,
                          scrollController: scrollController,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
