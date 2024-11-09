import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:healing_guide_flutter/features/common/future_cubit/future_cubit.dart';
import 'package:healing_guide_flutter/features/medical_specialty/medical_specialty.dart';
import 'package:healing_guide_flutter/features/medical_specialty/medical_specialty_cubit.dart';
import 'package:healing_guide_flutter/features/medical_specialty/repositories.dart';
import 'package:healing_guide_flutter/features/theme/app_theme.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class MedSpecialtiesSection extends StatelessWidget {
  const MedSpecialtiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicalSpecialtyCubit()..getSpecialties(),
      child: SizedBox(
        height: 90,
        child:
            BlocBuilder<MedicalSpecialtyCubit, FutureState<MedicalSpecialties>>(
          builder: (context, state) {
            return Skeletonizer(
              ignoreContainers: false,
              enabled: state.isLoading,
              child: switch (state) {
                ErrorFutureState<MedicalSpecialties>() => ListTile(
                    title: Text(context.l10n.undefinedException),
                    leading: const Icon(Icons.error),
                    iconColor: AppTheme.redColor,
                    dense: true,
                    trailing: IconButton(
                      onPressed:
                          context.read<MedicalSpecialtyCubit>().getSpecialties,
                      icon: const Icon(Icons.refresh_outlined),
                    ),
                  ),
                _ => ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => state.isLoading
                        ? const _CardSkeleton()
                        : _Card(state.data!.elementAt(index)),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    itemCount: state.isLoading ? 5 : state.data!.length,
                  ),
              },
            );
          },
        ),
      ),
    );
  }
}

class _CardSkeleton extends StatelessWidget {
  const _CardSkeleton();

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.circular(6);
    return Skeletonizer.zone(
      child: Card(
        elevation: 0,
        child: Column(
          children: [
            Bone.square(size: 55, borderRadius: borderRadius),
            const SizedBox(height: 10),
            Bone.text(words: 1, borderRadius: borderRadius),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card(this.specialty);
  final MedicalSpecialty specialty;
  @override
  Widget build(BuildContext context) {
    return Skeleton.unite(
      child: SizedBox(
        height: 80,
        child: Column(
          children: [
            Container(
              width: 55,
              height: 55,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xff4f94e5).withOpacity(.1),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 10),
            Text(specialty.name),
          ],
        ),
      ),
    );
  }
}
