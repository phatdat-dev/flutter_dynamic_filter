import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/src/shared/constants/my_constants.dart';
import 'package:flutter_dynamic_filter/src/shared/extension/app_extension.dart';
import 'package:provider/provider.dart';

import '../../models/enum/operator_type/operator_type.dart';
import '../../models/field.dart';
import '../../models/field_sort_order.dart';
import '../../shared/mixin/popup_search_list_field_statemixin.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widget/field_icon_text.dart';
import '../../shared/widget/my_outlined_button.dart';
import '../../shared/widget/my_popup_menu_item.dart';
import '../../shared/widget/my_text_button.dart';
import 'controller/sort_controller.dart';

part 'widget/button/add_sort_button.dart';
part 'widget/button/condition_sort_button.dart';
part 'widget/button/delete_all_sort_button.dart';
part 'widget/button/field_name_sort_button.dart';
part 'widget/sort_editor.dart';
part 'widget/sort_editor_item.dart';

class SortMenu extends StatelessWidget {
  const SortMenu({
    super.key,
    required this.sortOrders,
    required this.fields,
    this.onChanged,
  });
  final ValueNotifier<Set<FieldSortOrder>> sortOrders;
  // List of all fields when user want to sort by field
  final List<Field> fields;
  // can use sortOrders.listen or handle in onChanged
  final void Function(Set<FieldSortOrder> sortOrders)? onChanged;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: sortOrders,
      builder: (context, value, child) => MyOutlinedButton(
        label: value.isNotEmpty ? Text('${value.length} Sort') : const Text('Sort'),
        leading: const Icon(Icons.sort),
        onPressed: () async {
          final constraints = BoxConstraints.tight(const Size(300, 200));
          await HelperWidget.showPopupMenu(
            context: context,
            constraints: constraints,
            items: [
              MyPopupMenuItem(
                child: Provider(
                  create: (context) => SortController(
                    sortOrders: sortOrders,
                    fields: fields,
                  ),
                  builder: (context, child) => SortEditor(constraints: constraints),
                ),
              ),
            ],
          );
          onChanged?.call(sortOrders.value);
        },
      ),
    );
  }
}
