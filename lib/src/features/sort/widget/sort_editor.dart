// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

part of 'sort_menu.dart';

class SortEditor extends StatefulWidget {
  const SortEditor({super.key});

  @override
  State<SortEditor> createState() => _SortEditorState();
}

class _SortEditorState extends State<SortEditor> with SortControllerStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
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
            child: FieldNameSortButton(item: item),
          ),
          const SizedBox(width: 5),
          Expanded(
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
    _fields.removeWhere((e) => controller.sortOrders.value.any((sort) => sort.fieldName == e.fieldName));
  }

  void onShowPopupSort({
    required BuildContext context,
    required void Function(Field field) onSelected,
  }) {
    if (_fields.isNotEmpty) {
      HelperWidget.showPopupMenu(
        context: context,
        items: [
          CustomPopupMenuItem(
              child: popupBuilder(
            context: context,
            onSelected: onSelected,
          )),
        ],
      );
    }
  }

  Widget popupBuilder({
    required BuildContext context,
    required void Function(Field field) onSelected,
  }) {
    initFields();
    final search = ValueNotifier(_fields.toList());
    final txtController = TextEditingController();
    return Column(
      children: [
        if (_fields.length > 5)
          Container(
            height: 40,
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: txtController,
              onChanged: (value) => HelperReflect.search(listOrigin: _fields, listSearch: search, nameModel: 'queryName', keywordSearch: value),
              decoration: const InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search_rounded),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        SizedBox(
          width: 200,
          height: 300,
          child: ValueListenableBuilder(
            valueListenable: search,
            builder: (context, searchValue, child) => ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: searchValue.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: txtController.text.isEmpty
                      ? Text(
                          searchValue[index].queryName,
                        )
                      : RichText(
                          text: TextSpan(
                            children: HelperWidget.highlightOccurrences(searchValue[index].queryName, txtController.text),
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                          ),
                        ),
                  onTap: () {
                    onSelected(searchValue[index]);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
    // CreateViewSortList
  }
}
