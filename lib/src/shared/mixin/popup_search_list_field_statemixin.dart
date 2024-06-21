import 'package:flutter/material.dart';

import '../../models/field.dart';
import '../utils/helper_widget.dart';
import '../widget/my_popup_menu_item.dart';

mixin PopupSearchListFieldStateMixin<T extends StatefulWidget> on State<T> {
  (ValueNotifier<Iterable> list, List<Field> fields) get popUpListField;
  bool get allowDuplicate => false;

  late List<Field> _fields;

  @override
  void initState() {
    super.initState();
    initFields();
  }

  void initFields() {
    _fields = popUpListField.$2.toList();
    // remove where data is already in sortOrders
    if (!allowDuplicate) {
      _fields.removeWhere((e) => popUpListField.$1.value.any((sort) => sort.field == e));
    }
  }

  void showPopupSearchListField({
    required BuildContext context,
    required void Function(Field field) onSelected,
  }) {
    if (_fields.isNotEmpty) {
      initFields();
      HelperWidget.showPopupMenu(
        context: context,
        items: HelperWidget.buildSearchListFieldWidget(
          context: context,
          fields: _fields,
          onSelected: onSelected,
        ).map((e) => MyPopupMenuItem(child: e)).toList(),
      );
    }
  }
}
