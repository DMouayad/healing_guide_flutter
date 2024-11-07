import 'package:flutter/material.dart';
import 'package:healing_guide_flutter/features/search/models/search_result.dart';
import 'package:healing_guide_flutter/features/search/widgets/search_result_card.dart';
import 'package:healing_guide_flutter/utils/utils.dart';

class SearchCardWrapper extends StatelessWidget {
  const SearchCardWrapper({
    super.key,
    required this.onTap,
    required this.result,
  });
  final SearchResult result;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: context.colorScheme.inversePrimary,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(
                  237, 238, 251, context.isDarkMode ? 0.1 : 0.75),
              offset: const Offset(0, 5),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onTap,
          child: SearchResultCardContent(result),
        ),
      ),
    );
  }
}

class _Sheet extends StatefulWidget {
  const _Sheet(this.result, {super.key});
  final SearchResult result;
  @override
  State<_Sheet> createState() => __SheetState();
}

class __SheetState extends State<_Sheet> {
  final sheetController = DraggableScrollableController();
  static const initialHeightFraction = .7;
  final ValueNotifier<double> heightFractionNotifier =
      ValueNotifier(initialHeightFraction);

  @override
  void initState() {
    sheetController.addListener(() {
      print('sheet offset: ${sheetController.size}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return SearchResultCardContent(widget.result);
      },
    );
    // ValueListenableBuilder(
    //   valueListenable: heightFractionNotifier,
    //   builder: (context, value, _) {
    //     print(value);
    //     return FractionallySizedBox(
    //       heightFactor: .4,
    //       child: SearchResultCardContent(widget.result),
    //     );
    //   },
    // );
  }
}
