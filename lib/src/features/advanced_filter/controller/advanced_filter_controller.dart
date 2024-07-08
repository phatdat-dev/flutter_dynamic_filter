// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/src/shared/extension/app_extension.dart';

import '../../../../flutter_dynamic_filter.dart';

class AdvancedFilterController {
  final ValueNotifier<List<FieldAdvancedFilter>> advancedFilter;
  final List<Field> fields;

  late final ScrollController scrollController;

  AdvancedFilterController({
    required this.advancedFilter,
    required this.fields,
  });

  void onChangedShortFilter(Field field) {
    advancedFilter.value = [];
  }

  void onAddAdvancedFilter() {
    advancedFilter
      ..value.add(FieldAdvancedFilter(
        field: fields.randomElement,
      ))
      ..notifyListeners();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      },
    );
  }

  void onDeleteAllAdvancedFilter() {
    advancedFilter.value = [];
  }

  void onDeleteAdvancedFilter(FieldAdvancedFilter item) {
    advancedFilter
      ..value.remove(item)
      ..notifyListeners();
  }

  void onDuplicateAdvancedFilter(FieldAdvancedFilter item) {
    advancedFilter
      ..value.add(item.copyWith())
      ..notifyListeners();
  }

  void onChangedname(FieldAdvancedFilter item, Field e) {
    item.field = e;
    item.operatorType = e.type.defaultType;
    // rebuild inline widget
    item.notifyListeners();
  }

  void onChangedFieldOperator(FieldAdvancedFilter item, OperatorType e) {
    item.operatorType = e;
    // rebuild inline widget
    item.notifyListeners();
  }
}
