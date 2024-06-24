import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/src/shared/mixin/popup_search_list_field_statemixin.dart';
import 'package:flutter_dynamic_filter/src/shared/utils/print.dart';
import 'package:flutter_dynamic_filter/src/shared/widget/my_outlined_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/base_field_value/date_field_value.dart';
import '../../models/enum/field_type.dart';
import '../../models/enum/operator_type/operator_type.dart';
import '../../models/field.dart';
import '../../models/field_advanced_filter.dart';
import '../../shared/constants/my_constants.dart';
import '../../shared/utils/helper_widget.dart';
import '../../shared/widget/field_icon_text.dart';
import '../../shared/widget/my_popup_menu_item.dart';
import '../../shared/widget/my_text_button.dart';
import 'controller/advanced_filter_controller.dart';

part 'widget/advanced_filter_editor.dart';
part 'widget/advanced_filter_editor_item.dart';
part 'widget/button/add_advanced_filter_button.dart';
part 'widget/button/date_operator_type_filter_editor_item_button.dart';
part 'widget/button/delete_all_advanced_filter_button.dart';
part 'widget/button/field_name_filter_button.dart';
part 'widget/button/field_operator_button.dart';
part 'widget/button/filter_mustmatch_button.dart';
part 'widget/button/option_advanced_filter_button.dart';

class AdvancedFilterButton extends StatelessWidget {
  const AdvancedFilterButton({
    super.key,
    this.onChanged,
    required this.advancedFilter,
    required this.fields,
  });
  final ValueNotifier<List<FieldAdvancedFilter>> advancedFilter;
  final List<Field> fields;
  final void Function(List<FieldAdvancedFilter> data)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: advancedFilter,
      builder: (context, value, child) => MyOutlinedButton(
        label: value.isNotEmpty ? Text("${value.length} rules") : const Text('Add Filter'),
        leading: value.isNotEmpty ? const Icon(Icons.filter_alt_outlined) : const Icon(Icons.add_outlined),
        onPressed: () async {
          final constraints = BoxConstraints.tight(const Size(700, 320));
          await HelperWidget.showPopupMenu(
            context: context,
            constraints: constraints,
            items: [
              MyPopupMenuItem(
                child: Provider(
                  create: (context) => AdvancedFilterController(
                    advancedFilter: advancedFilter,
                    fields: fields,
                  ),
                  builder: (context, child) => AdvancedFilterEditor(constraints: constraints),
                ),
              ),
            ],
          );
          onChanged?.call(advancedFilter.value);
        },
      ),
    );
  }
}
