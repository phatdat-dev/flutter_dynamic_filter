part of '../../advanced_filter_button.dart';

class FieldNameFilterButton extends StatefulWidget {
  const FieldNameFilterButton({super.key});

  @override
  State<FieldNameFilterButton> createState() => _FieldNameFilterButtonState();
}

class _FieldNameFilterButtonState extends State<FieldNameFilterButton>
    with AdvancedFilterControllerStateMixin, PopupSearchListFieldStateMixin, FieldAdvancedFilterItemStateMixin {
  @override
  (ValueNotifier<Iterable> list, List<Field> fields) get popUpListField => (controller.advancedFilter, controller.fields);

  @override
  bool get allowDuplicate => true;

  @override
  Widget build(BuildContext context) {
    return MyOutlinedButton(
      label: FieldIconText(
        field: item.field,
      ),
      onPressed: () => showPopupSearchListField(
        context: context,
        onSelected: (field) => controller.onChangedname(item, field),
      ),
    );
  }
}
