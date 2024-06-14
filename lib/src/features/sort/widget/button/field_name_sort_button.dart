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

class _FieldNameSortButtonState extends State<FieldNameSortButton> with SortControllerStateMixin, SortControllerAddStateMixin {
  @override
  Widget build(BuildContext context) {
    return MyOutlinedButton(
      label: Text(
        widget.item.fieldName,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onPressed: () => onShowPopupSort(
        context: context,
        onSelected: (field) {
          controller.onChangedFieldNameSortOrder(widget.item, field);
          setState(() {});
        },
      ),
    );
  }
}
