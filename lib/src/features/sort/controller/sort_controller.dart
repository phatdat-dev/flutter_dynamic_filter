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
    sortOrders.value.add(FieldSortOrder(field, OrderByOperator.ascending));
    sortOrders.notifyListeners();
  }

  void onDeleteFieldSortOrder(FieldSortOrder item) {
    sortOrders.value.remove(item);
    sortOrders.notifyListeners();
  }

  void onChangednameSortOrder(FieldSortOrder item, Field e) {
    item.field = e;
  }

  void onChangedOrderBySortOrder(FieldSortOrder item, OrderByOperator e) {
    item.orderBy = e;
  }

  void onDeleteAllSort() {
    sortOrders.value = {};
  }
}
