import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/src/shared/constants/my_constants.dart';
import 'package:flutter_dynamic_filter/src/shared/extension/app_extension.dart';
import 'package:provider/provider.dart';

import '../../models/field.dart';
import '../../models/field_sort_order.dart';
import '../../models/enum/filter_enum.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widget/field_icon_text.dart';
import '../../shared/widget/my_outlined_button.dart';
import '../../shared/widget/my_popup_menu_item.dart';
import 'controller/sort_controller.dart';

part 'widget/button/add_sort_button.dart';
part 'widget/button/condition_sort_button.dart';
part 'widget/button/delete_all_sort_button.dart';
part 'widget/button/field_name_sort_button.dart';
part 'widget/sort_editor.dart';

class SortMenu extends StatelessWidget {
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
  // can use sortOrders.listen or handle in onChanged
  final void Function(Set<FieldSortOrder> sortOrders)? onChanged;
  @override
  Widget build(BuildContext context) {
    return MyOutlinedButton(
      label: label ?? const Text('Sort'),
      leading: leading ?? const Icon(Icons.sort),
      onPressed: () async {
        await HelperWidget.showPopupMenu(
          context: context,
          items: [
            MyPopupMenuItem(
              child: Provider(
                create: (context) => SortController(
                  sortOrders: sortOrders,
                  fields: fields,
                ),
                builder: (context, child) => const SortEditor(),
              ),
            ),
          ],
        );
        onChanged?.call(sortOrders.value);
      },
    );
  }
}
