import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healing_guide_flutter/features/home/components/custom_drawer.dart';
import 'package:healing_guide_flutter/features/home/components/home_section.dart';
import 'package:healing_guide_flutter/features/home/components/nearby_facilities_section.dart';
import 'package:healing_guide_flutter/features/search/cubit/search_cubit.dart';
import 'package:healing_guide_flutter/features/search/widgets/custom_search_bar.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

import 'components/med_specialties_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const sliverGap24 = SliverPadding(padding: EdgeInsets.all(12));
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
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
                    const FakeSearchBar(),
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
                    title: context.l10n.homeSpecialtiesSectionTitle,
                    content: const MedSpecialtiesSection(),
                  ),
                  const SizedBox(height: 16),
                  HomeScreenSection(
                    title: context.l10n.homeFacilitiesSectionTitle,
                    content: NearbyFacilitiesSection(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
