part of '../advanced_filter_anchor.dart';

class AdvancedFilterEditor extends StatefulWidget {
  const AdvancedFilterEditor({
    super.key,
    this.constraints,
    this.scrollController,
  });
  final BoxConstraints? constraints;
  final ScrollController? scrollController;

  @override
  State<AdvancedFilterEditor> createState() => _AdvancedFilterEditorState();
}

class _AdvancedFilterEditorState extends State<AdvancedFilterEditor> with AdvancedFilterControllerStateMixin {
  @override
  void initState() {
    super.initState();
    controller.scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: widget.constraints ?? BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return ValueListenableBuilder(
      valueListenable: controller.advancedFilter,
      builder: (context, value, child) => ReorderableListView(
        onReorder: (oldIndex, newIndex) {},
        scrollController: widget.scrollController == null ? controller.scrollController : null,
        shrinkWrap: true,
        primary: false,
        buildDefaultDragHandles: false,
        footer: _buildFooter(),
        children: value.mapIndexed((index, item) {
          return MultiProvider(
            key: ValueKey(item),
            providers: [
              ChangeNotifierProvider.value(value: item),
              Provider.value(value: index),
            ],
            builder: (context, _) => const AdvancedFilterEditorItem(),
          );
        }).toList(),
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
