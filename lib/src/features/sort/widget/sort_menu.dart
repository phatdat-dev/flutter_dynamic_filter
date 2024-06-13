import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/src/shared/extension/app_extension.dart';
import 'package:flutter_dynamic_filter/src/shared/widget/custom_popup_menu_item.dart';
import 'package:provider/provider.dart';

import '../../../models/field.dart';
import '../../../models/filter_enum.dart';
import '../../../shared/utils/utils.dart';
import '../controller/sort_controller.dart';
import 'sort_choice_chip.dart';

part 'button/add_sort_button.dart';
part 'button/condition_sort_button.dart';
part 'button/delete_all_sort_button.dart';
part 'button/field_name_sort_button.dart';
part 'sort_editor.dart';

// ignore: must_be_immutable
class FieldSortOrder extends Equatable {
  String fieldName;
  OrderBy orderBy;

  FieldSortOrder(
    this.fieldName,
    this.orderBy,
  );

  @override
  List<Object?> get props => [fieldName];
}

class SortMenu extends StatefulWidget {
  const SortMenu({
    super.key,
    this.label,
    this.leading,
    required this.sortOrders,
    required this.fields,
    this.onChanged,
  });
  final Widget? label;
  final Widget? leading;
  final ValueNotifier<Set<FieldSortOrder>> sortOrders;
  // List of all fields when user want to sort by field
  final List<Field> fields;
  final void Function(Set<FieldSortOrder> sortOrders)? onChanged;

  @override
  State<SortMenu> createState() => _SortMenuState();
}

class _SortMenuState extends State<SortMenu> {
  @override
  Widget build(BuildContext context) {
    return SortChoiceChip(
      label: widget.label ?? const Text('Sort'),
      leading: widget.leading ?? const Icon(Icons.sort),
      onPressed: () async {
        await HelperWidget.showPopupMenu(
          context: context,
          items: [
            CustomPopupMenuItem(
              child: Provider(
                create: (context) => SortController(
                  sortOrders: widget.sortOrders,
                  fields: widget.fields,
                ),
                builder: (context, child) => const SortEditor(),
              ),
            ),
          ],
        );
        widget.onChanged?.call(widget.sortOrders.value);
      },
    );
  }
}
