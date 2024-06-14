part of '../advanced_filter_button.dart';

class AdvancedFilterEditor extends StatefulWidget {
  const AdvancedFilterEditor({super.key});

  @override
  State<AdvancedFilterEditor> createState() => _AdvancedFilterEditorState();
}

class _AdvancedFilterEditorState extends State<AdvancedFilterEditor> with ShortControllerStateMixin {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 320,
      // padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
      // child: ValueListenableBuilder(
      //   valueListenable: controller.advancedFilter,
      //   builder: (context, value, child) => ReorderableListView(
      //     onReorder: (oldIndex, newIndex) => controller.sortOrders.value = value.onReorder(oldIndex, newIndex),
      //     shrinkWrap: true,
      //     buildDefaultDragHandles: false,
      //     footer: const IconTheme(
      //       data: IconThemeData(size: 16),
      //       child: Row(
      //         children: [
      //           Expanded(child: AddSortButton()),
      //           SizedBox(width: 5),
      //           Expanded(child: DeleteAllSortsButton()),
      //         ],
      //       ),
      //     ),
      //     children: value.mapIndexed((index, item) {
      //       return SortItem(
      //         key: UniqueKey(),
      //         index: index,
      //         item: item,
      //         onDeleted: () => controller.onDeleteFieldSortOrder(item),
      //       );
      //     }).toList(),
      //   ),
      // ),
    );
  }
}

mixin ShortControllerStateMixin<T extends StatefulWidget> on State<T> {
  late final AdvancedFilterController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<AdvancedFilterController>();
  }
}
