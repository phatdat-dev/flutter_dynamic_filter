import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/src/models/enum/field_type.dart';
import 'package:flutter_dynamic_filter/src/shared/widget/flowy_svg.dart';
import 'package:flutter_dynamic_filter/src/shared/widget/my_outlined_button.dart';
import 'package:provider/provider.dart';

import '../../models/field.dart';
import '../../shared/utils/helper_widget.dart';
import '../../shared/widget/my_popup_menu_item.dart';
import 'controller/advanced_filter_controller.dart';

part 'widget/advanced_filter_editor.dart';

class AdvancedFilterButton extends StatelessWidget {
  const AdvancedFilterButton({
    super.key,
    this.onChanged,
    required this.advancedFilter,
    required this.fields,
  });
  final ValueNotifier<FieldAdvancedFilter?> advancedFilter;
  final List<Field> fields;
  final void Function(dynamic data)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: advancedFilter,
      builder: (context, value, child) => MyOutlinedButton(
        label: value != null ? Text(value.field.queryName) : const Text('Add Filter'),
        leading: value != null ? FlowySvg(value.field.fieldType.svgData) : const Icon(Icons.add_outlined),
        onPressed: () async {
          await HelperWidget.showPopupMenu(
            context: context,
            items: [
              MyPopupMenuItem(
                child: Provider(
                  create: (context) => AdvancedFilterController(
                    advancedFilter: advancedFilter,
                    fields: fields,
                  ),
                  builder: (context, child) => const AdvancedFilterEditor(),
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
