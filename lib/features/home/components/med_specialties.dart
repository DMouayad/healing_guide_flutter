import 'package:flutter/material.dart';

class MedSpecialty {
  final String name;
  final String iconURL;

  const MedSpecialty({required this.name, required this.iconURL});
}

class MedSpecialties extends StatelessWidget {
  const MedSpecialties({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [];
    return ListView.separated(
      itemBuilder: (context, index) => _Card(title: '$index', iconPath: ''),
      separatorBuilder: (context, index) => const SizedBox(width: 16),
      itemCount: items.length,
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.iconPath});
  final String title;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return OverflowBar(
      spacing: 10,
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
        Text(title),
      ],
    );
  }
}
