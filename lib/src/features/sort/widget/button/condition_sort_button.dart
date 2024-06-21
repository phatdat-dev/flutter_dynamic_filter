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
      items: OrderByOperator.values
          .map(
            (e) => HelperWidget.popupMenuItemCheck(
              context: context,
              value: e,
              selected: widget.item.orderBy,
              label: e.name,
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
