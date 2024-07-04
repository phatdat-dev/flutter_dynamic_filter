// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

part of '../../sort_anchor.dart';

class AddSortButton extends StatefulWidget {
  const AddSortButton({
    super.key,
  });

  @override
  State<AddSortButton> createState() => _AddSortButtonState();
}

class _AddSortButtonState extends State<AddSortButton> with SortControllerStateMixin, PopupSearchListFieldStateMixin {
  @override
  (ValueNotifier<Set> list, List<Field> fields) get popUpListField => (controller.sortOrders, controller.fields);

  @override
  Widget build(BuildContext context) {
    return MyTextButton(
      icon: const Icon(Icons.add, color: Colors.green),
      label: "Add Sort",
      onPressed: () => showPopupSearchListField(
        context: context,
        onSelected: (field) {
          controller.onAddFieldSortOrder(field);
        },
      ),
    );
  }
}
