part of '../sort_menu.dart';

class DeleteAllSortsButton extends StatelessWidget {
  const DeleteAllSortsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SortController>();

    // if (controller.sortOrders.value.isEmpty) return const SizedBox();
    return _MyTextButton(
      icon: const Icon(Icons.delete_forever_outlined, color: Colors.red),
      label: "Delete All Sorts",
      onPressed: () {
        controller.onDeleteAllSort();
        Navigator.of(context).pop();
      },
    );
  }
}

class _MyTextButton extends StatelessWidget {
  const _MyTextButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  final Icon icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(5),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 5),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
