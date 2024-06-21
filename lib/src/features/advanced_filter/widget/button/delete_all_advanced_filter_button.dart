part of '../../advanced_filter_button.dart';

class DeleteAllAdvancedFilterButton extends StatelessWidget {
  const DeleteAllAdvancedFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AdvancedFilterController>();
    return MyTextButton(
      icon: const Icon(Icons.delete_forever_outlined, color: Colors.red),
      label: "Delete All Sorts",
      onPressed: () {
        controller.onDeleteAllAdvancedFilter();
        Navigator.of(context).pop();
      },
    );
  }
}
