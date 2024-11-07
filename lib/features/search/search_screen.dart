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
  const SearchScreen({super.key});

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
      if (!sheetIsOpening && sheetController.size < initialChildSize) {
        double opacity = sheetController.size;
        _opacityNotifier.value = opacity;
      }
      if (sheetController.size == initialChildSize) {
        _opacityNotifier.value = 1;
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
    _opacityNotifier.value = 1;
    setState(() {});
  }

  Future<void> showSheet(SearchResult result) async {
    sheetIsOpening = true;
    setState(() => selectedResult = result);
    await Future.delayed(const Duration(milliseconds: 50));
    await sheetController.animateTo(
      initialChildSize,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
    sheetIsOpening = false;
  }

  @override
  void dispose() {
    sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
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
                            const CustomSearchBar(),
                            SearchFiltersSection(context.read()),
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
                  bottom: (context.screenHeight * initialChildSize) - 60,
                  child: GestureDetector(
                    onTap: hideSheet,
                    child: ValueListenableBuilder(
                      valueListenable: _opacityNotifier,
                      child: FutureBuilder(
                        future: Future.delayed(const Duration(seconds: 5)),
                        builder: (context, snapshot) {
                          return switch (snapshot.connectionState) {
                            ConnectionState.done => const _ScrollDownHint(),
                            _ => const SizedBox()
                          };
                        },
                      ),
                      builder: (context, value, child) {
                        return Container(
                          color: Colors.black.withOpacity(value * .4),
                          padding: const EdgeInsets.only(bottom: 50),
                          alignment: Alignment.bottomCenter,
                          child: value > 0.5 ? child : const SizedBox(),
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

class _ScrollDownHint extends StatefulWidget {
  const _ScrollDownHint({
    super.key,
  });

  @override
  State<_ScrollDownHint> createState() => _ScrollDownHintState();
}

class _ScrollDownHintState extends State<_ScrollDownHint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final _tween = Tween(begin: const Offset(0, 1), end: const Offset(0, -1));
  late Timer timer;
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animationController.repeat(reverse: true);
    timer = Timer(const Duration(seconds: 20), () {
      if (_animationController.isAnimating) {
        _animationController.stop();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SlideTransition(
            position: _tween.animate(_animationController),
            child: const Icon(
              Icons.arrow_circle_up_outlined,
              color: Colors.white,
              size: 40,
            ),
          ),
          Chip(
            elevation: 0,
            side: BorderSide.none,
            label: Text(
              'Swap up to view full information',
              style: context.myTxtTheme.bodyMedium
                  .copyWith(color: context.colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}
