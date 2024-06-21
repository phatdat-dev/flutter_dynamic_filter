part of '../sort_button.dart';

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
      height: MyConstants.popupMenuItemHeight,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: MyConstants.paddingField),
          ReorderableDragStartListener(
            index: index,
            child: const Icon(
              Icons.drag_indicator,
              size: MyConstants.iconSizeSmall,
            ),
          ),
          const SizedBox(width: MyConstants.paddingField),
          Expanded(
            flex: 7,
            child: FieldNameSortButton(item: item),
          ),
          const SizedBox(width: MyConstants.paddingField),
          Expanded(
            flex: 6,
            child: ConditionSortButton(item: item),
          ),
          InkWell(
            onTap: onDeleted,
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close, size: MyConstants.iconSizeSmall),
            ),
          ),
        ],
      ),
    );
  }
}
