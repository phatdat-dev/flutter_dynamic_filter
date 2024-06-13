// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

part of '../sort_menu.dart';

class AddSortButton extends StatefulWidget {
  const AddSortButton({
    super.key,
  });

  @override
  State<AddSortButton> createState() => _AddSortButtonState();
}

class _AddSortButtonState extends State<AddSortButton> with SortControllerStateMixin, SortControllerAddStateMixin {
  @override
  Widget build(BuildContext context) {
    return _MyTextButton(
      icon: const Icon(Icons.add, color: Colors.green),
      label: "Add Sort",
      onPressed: () => onShowPopupSort(
        context: context,
        onSelected: (field) {
          controller.onAddFieldSortOrder(field);
        },
      ),
    );
  }
}
