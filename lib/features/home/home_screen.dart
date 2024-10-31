import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/features/home/components/custom_drawer.dart';
import 'package:healing_guide_flutter/features/home/components/home_section.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

import 'components/custom_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const sliverGap24 = SliverPadding(padding: EdgeInsets.all(12));
    return Scaffold(
      drawer: const CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          PinnedHeaderSliver(
            child: Container(
              padding: const EdgeInsets.only(top: 50, bottom: 25),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
                gradient: LinearGradient(
                  colors: [Color(0xFF4F94E5), Color(0xFF009D6D)],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        const DrawerButton(color: Colors.white),
                        Text(
                          context.l10n.homeGreeting,
                          style: context.myTxtTheme.titleSmall
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const CustomSearchBar(),
                ],
              ),
            ),
          ),
          sliverGap24,
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            sliver: SliverList.list(
              children: [
                HomeScreenSection(
                    title: context.l10n.homeSpecialtiesSectionTitle),
                const SizedBox(height: 16),
                HomeScreenSection(
                    title: context.l10n.homeFacilitiesSectionTitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
