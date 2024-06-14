import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../flutter_dynamic_filter.dart';

class FieldAdvancedFilter extends Equatable {
  final Field field;
  const FieldAdvancedFilter({
    required this.field,
  });

  @override
  List<Object?> get props => [field];
}

class AdvancedFilterController {
  final ValueNotifier<FieldAdvancedFilter?> advancedFilter;
  final List<Field> fields;

  AdvancedFilterController({
    required this.advancedFilter,
    required this.fields,
  });

  void onChangedShortFilter(Field field) {
    advancedFilter.value = FieldAdvancedFilter(field: field);
  }
}
