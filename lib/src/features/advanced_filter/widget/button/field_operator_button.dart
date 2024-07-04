part of '../../advanced_filter_anchor.dart';

class FieldOperatorButton extends StatefulWidget {
  const FieldOperatorButton({super.key});

  @override
  State<FieldOperatorButton> createState() => _FieldOperatorButtonState();
}

class _FieldOperatorButtonState extends State<FieldOperatorButton> with AdvancedFilterControllerStateMixin, FieldAdvancedFilterItemStateMixin {
  void _showConditionPopupMenu(BuildContext context) {
    HelperWidget.showPopupMenu(
      context: context,
      items: item.field.type.operatorType.map(
        (e) {
          (e as OperatorType);
          return HelperWidget.popupMenuItemCheck(
            context: context,
            value: e,
            selected: item.operatorType,
            label: e.label,
            onTap: () => controller.onChangedFieldOperator(item, e),
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyOutlinedButton(
      label: Text(item.operatorType.label),
      onPressed: () => _showConditionPopupMenu(context),
    );
  }
}
