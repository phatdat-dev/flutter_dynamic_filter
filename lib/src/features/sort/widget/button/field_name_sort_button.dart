part of '../../sort_button.dart';

class FieldNameSortButton extends StatefulWidget {
  const FieldNameSortButton({
    super.key,
    required this.item,
  });
  final FieldSortOrder item;

  @override
  State<FieldNameSortButton> createState() => _FieldNameSortButtonState();
}

class _FieldNameSortButtonState extends State<FieldNameSortButton> with SortControllerStateMixin, PopupSearchListFieldStateMixin {
  @override
  (ValueNotifier<Set> list, List<Field> fields) get popUpListField => (controller.sortOrders, controller.fields);

  @override
  Widget build(BuildContext context) {
    return MyOutlinedButton(
      label: FieldIconText(
        field: widget.item.field,
      ),
      onPressed: () => showPopupSearchListField(
        context: context,
        onSelected: (field) {
          controller.onChangednameSortOrder(widget.item, field);
          setState(() {});
        },
      ),
    );
  }
}
