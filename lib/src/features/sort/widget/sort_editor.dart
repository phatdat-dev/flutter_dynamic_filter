// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

part of '../sort_button.dart';

class SortEditor extends StatefulWidget {
  const SortEditor({super.key});

  @override
  State<SortEditor> createState() => _SortEditorState();
}

class _SortEditorState extends State<SortEditor> with SortControllerStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 200,
      // padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: ValueListenableBuilder(
        valueListenable: controller.sortOrders,
        builder: (context, value, child) => ReorderableListView(
          onReorder: (oldIndex, newIndex) => controller.sortOrders.value = value.onReorder(oldIndex, newIndex),
          shrinkWrap: true,
          buildDefaultDragHandles: false,
          footer: const IconTheme(
            data: IconThemeData(size: 16),
            child: Row(
              children: [
                Expanded(child: AddSortButton()),
                SizedBox(width: 5),
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

class SortItem extends StatelessWidget {
  const SortItem({
    super.key,
    required this.index,
    required this.item,
    this.onDeleted,
  });

  final int index;
  final FieldSortOrder item;
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 5),
          ReorderableDragStartListener(
            index: index,
            child: const Icon(
              Icons.drag_indicator,
              size: 16,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 7,
            child: FieldNameSortButton(item: item),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 6,
            child: ConditionSortButton(item: item),
          ),
          InkWell(
            onTap: onDeleted,
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close, size: 16),
            ),
          ),
        ],
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

mixin SortControllerAddStateMixin<T extends StatefulWidget> on SortControllerStateMixin<T> {
  late List<Field> _fields;

  @override
  void initState() {
    super.initState();
    initFields();
  }

  void initFields() {
    _fields = controller.fields.toList();
    // remove where data is already in sortOrders
    _fields.removeWhere((e) => controller.sortOrders.value.any((sort) => sort.field == e));
  }

  void onShowPopupSort({
    required BuildContext context,
    required void Function(Field field) onSelected,
  }) {
    if (_fields.isNotEmpty) {
      initFields();
      HelperWidget.showPopupMenu(
        context: context,
        items: HelperWidget.buildSearchListFieldWidget(
          context: context,
          fields: _fields,
          onSelected: onSelected,
        ).map((e) => MyPopupMenuItem(child: e)).toList(),
      );
    }
  }
}
