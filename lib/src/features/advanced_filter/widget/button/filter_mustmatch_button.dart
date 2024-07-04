// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

part of '../../advanced_filter_anchor.dart';

class FilterMustmatchButton extends StatefulWidget {
  const FilterMustmatchButton({super.key});

  @override
  State<FilterMustmatchButton> createState() => _FilterMustmatchButtonState();
}

class _FilterMustmatchButtonState extends State<FilterMustmatchButton> with AdvancedFilterControllerStateMixin {
  late final int index;
  @override
  void initState() {
    index = context.read<int>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return const Text(
        "Where",
        textAlign: TextAlign.right,
      );
    }

    var item = controller.advancedFilter.value.elementAt(1);
    if (index == 1) {
      return MyOutlinedButton(
        label: Text(item.mustMatch.label),
        onPressed: () async {
          final result = await HelperWidget.showPopupMenu(
            context: context,
            items: FilterMustMatch.values
                .map((e) => PopupMenuItem(
                      value: e,
                      child: Text(e.label),
                    ))
                .toList(),
          );
          if (result != null && result != item.mustMatch) {
            item.mustMatch = result;
            controller.advancedFilter.notifyListeners();
          }
        },
      );
    }

    return Text(
      item.mustMatch.label,
      textAlign: TextAlign.right,
    );
  }
}
