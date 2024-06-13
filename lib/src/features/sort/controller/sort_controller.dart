// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';

import '../../../../flutter_dynamic_filter.dart';

class SortController {
  final ValueNotifier<Set<FieldSortOrder>> sortOrders;
  final List<Field> fields;
  SortController({
    required this.sortOrders,
    required this.fields,
  });

  void onAddFieldSortOrder(Field field) {
    sortOrders.value.add(FieldSortOrder(field.fieldName, OrderBy.ascending));
    sortOrders.notifyListeners();
  }

  void onDeleteFieldSortOrder(FieldSortOrder item) {
    sortOrders.value.remove(item);
    sortOrders.notifyListeners();
  }

  void onChangedFieldNameSortOrder(FieldSortOrder item, Field e) {
    item.fieldName = e.fieldName;
  }

  void onChangedOrderBySortOrder(FieldSortOrder item, OrderBy e) {
    item.orderBy = e;
  }

  void onDeleteAllSort() {
    sortOrders.value = {};
  }
}
