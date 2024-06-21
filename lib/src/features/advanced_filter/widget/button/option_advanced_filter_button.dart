part of '../../advanced_filter_button.dart';

class OptionAdvancedFilterButton extends StatefulWidget {
  const OptionAdvancedFilterButton({super.key});

  @override
  State<OptionAdvancedFilterButton> createState() => _OptionAdvancedFilterButtonState();
}

class _OptionAdvancedFilterButtonState extends State<OptionAdvancedFilterButton>
    with AdvancedFilterControllerStateMixin, FieldAdvancedFilterItemStateMixin {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      iconSize: MyConstants.iconSizeSmall,
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: () => controller.onDeleteAdvancedFilter(item),
          textStyle: Theme.of(context).textTheme.bodyMedium,
          child: const Row(
            children: [
              Icon(Icons.delete_outline, size: MyConstants.iconSizeSmall),
              SizedBox(width: MyConstants.paddingField),
              Text('Delete'),
            ],
          ),
        ),
        PopupMenuItem(
          onTap: () => controller.onDuplicateAdvancedFilter(item),
          textStyle: Theme.of(context).textTheme.bodyMedium,
          child: const Row(
            children: [
              Icon(Icons.copy_outlined, size: MyConstants.iconSizeSmall),
              SizedBox(width: MyConstants.paddingField),
              Text('Duplicate'),
            ],
          ),
        ),
      ],
      child: const Icon(Icons.more_horiz),
    );
  }
}
