part of '../../sort_button.dart';

class ConditionSortButton extends StatefulWidget {
  const ConditionSortButton({
    super.key,
    required this.item,
  });
  final FieldSortOrder item;

  @override
  State<ConditionSortButton> createState() => _ConditionSortButtonState();
}

class _ConditionSortButtonState extends State<ConditionSortButton> with SortControllerStateMixin {
  void _showConditionPopupMenu(BuildContext context) {
    HelperWidget.showPopupMenu(
      context: context,
      items: OrderBy.values
          .map(
            (e) => PopupMenuItem(
              value: e,
              height: MyConstants.popupMenuItemHeight,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      e.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  if (widget.item.orderBy == e) const Icon(Icons.check, color: Colors.green, size: 16),
                ],
              ),
              onTap: () {
                controller.onChangedOrderBySortOrder(widget.item, e);
                setState(() {});
              },
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyOutlinedButton(
      label: Text(widget.item.orderBy.name),
      onPressed: () => _showConditionPopupMenu(context),
    );
  }
}
