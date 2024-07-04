part of '../advanced_filter_anchor.dart';

class AdvancedFilterEditor extends StatefulWidget {
  const AdvancedFilterEditor({
    super.key,
    required this.constraints,
  });
  final BoxConstraints constraints;

  @override
  State<AdvancedFilterEditor> createState() => _AdvancedFilterEditorState();
}

class _AdvancedFilterEditorState extends State<AdvancedFilterEditor> with AdvancedFilterControllerStateMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: widget.constraints,
        child: ValueListenableBuilder(
          valueListenable: controller.advancedFilter,
          builder: (context, value, child) => ReorderableListView(
            onReorder: (oldIndex, newIndex) {},
            shrinkWrap: true,
            buildDefaultDragHandles: false,
            footer: _buildFooter(),
            children: value.mapIndexed((index, item) {
              return MultiProvider(
                key: UniqueKey(),
                providers: [
                  ChangeNotifierProvider.value(value: item),
                  Provider.value(value: index),
                ],
                builder: (context, _) => const AdvancedFilterEditorItem(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: IconTheme(
        data: IconThemeData(size: MyConstants.iconSizeSmall),
        child: Row(
          children: [
            Expanded(child: AddAdvancedFilterButton()),
            SizedBox(width: MyConstants.paddingField),
            Expanded(child: DeleteAllAdvancedFilterButton()),
          ],
        ),
      ),
    );
  }
}

mixin AdvancedFilterControllerStateMixin<T extends StatefulWidget> on State<T> {
  late final AdvancedFilterController controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<AdvancedFilterController>();
  }
}

mixin FieldAdvancedFilterItemStateMixin<T extends StatefulWidget> on State<T> {
  late final FieldAdvancedFilter item;

  @override
  void initState() {
    super.initState();
    item = context.read<FieldAdvancedFilter>();
  }
}
