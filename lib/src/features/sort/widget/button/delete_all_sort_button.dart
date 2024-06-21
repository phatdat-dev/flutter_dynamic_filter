part of '../../sort_button.dart';

class DeleteAllSortsButton extends StatelessWidget {
  const DeleteAllSortsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SortController>();

    // if (controller.sortOrders.value.isEmpty) return const SizedBox();
    return MyTextButton(
      icon: const Icon(Icons.delete_forever_outlined, color: Colors.red),
      label: "Delete All Sorts",
      onPressed: () {
        controller.onDeleteAllSort();
        Navigator.of(context).pop();
      },
    );
  }
}
