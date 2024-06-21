part of '../../advanced_filter_button.dart';

class AddAdvancedFilterButton extends StatelessWidget {
  const AddAdvancedFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AdvancedFilterController>();
    return MyTextButton(
      icon: const Icon(Icons.add, color: Colors.green),
      label: "Add filter",
      onPressed: controller.onAddAdvancedFilter,
    );
  }
}
