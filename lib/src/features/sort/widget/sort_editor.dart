// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

part of '../sort_button.dart';

class SortEditor extends StatefulWidget {
  const SortEditor({
    super.key,
    required this.constraints,
  });
  final BoxConstraints constraints;

  @override
  State<SortEditor> createState() => _SortEditorState();
}

class _SortEditorState extends State<SortEditor> with SortControllerStateMixin {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: widget.constraints,
      // padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: ValueListenableBuilder(
        valueListenable: controller.sortOrders,
        builder: (context, value, child) => ReorderableListView(
          onReorder: (oldIndex, newIndex) => controller.sortOrders.value = value.onReorder(oldIndex, newIndex),
          shrinkWrap: true,
          buildDefaultDragHandles: false,
          footer: const IconTheme(
            data: IconThemeData(size: MyConstants.iconSizeSmall),
            child: Row(
              children: [
                Expanded(child: AddSortButton()),
                SizedBox(width: MyConstants.paddingField),
                Expanded(child: DeleteAllSortsButton()),
              ],
            ),
          ),
          children: value.mapIndexed((index, item) {
            return SortItem(
              key: UniqueKey(),
              index: index,
              item: item,
              onDeleted: () => controller.onDeleteFieldSortOrder(item),
            );
          }).toList(),
        ),
      ),
    );
  }
}

mixin SortControllerStateMixin<T extends StatefulWidget> on State<T> {
  late final SortController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<SortController>();
  }
}
