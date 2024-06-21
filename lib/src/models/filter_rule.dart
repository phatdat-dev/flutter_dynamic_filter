// ignore_for_file: must_be_immutable

import 'base_field.dart';
import 'enum/operator_type/operator_type.dart';

class FilterRule extends BaseField {
  final OperatorType operator;

  FilterRule({
    required super.name, // 'age'
    required this.operator, // 'contains'
    required super.value, // '20'
  });

  // apply
  bool apply(Map<String, dynamic> data) {
    if (operator is TextOperator) {
      switch (operator) {
        case TextOperator.iss:
          return data[name] == value;
        case TextOperator.isNot:
          return data[name] != value;
        case TextOperator.contains:
          return data[name].contains(value);
        case TextOperator.doesNotContain:
          return !data[name].contains(value);
        case TextOperator.startsWith:
          return data[name].startsWith(value);
        case TextOperator.endsWith:
          return data[name].endsWith(value);
        case TextOperator.isEmpty:
          return data[name].isEmpty;
        case TextOperator.isNotEmpty:
          return data[name].isNotEmpty;
      }
    }
    throw Exception('Invalid operator: $operator');
  }
}

class FilterGroup {
  final String name;
  final List<FilterRule> rules;
  final String logic;

  FilterGroup({
    this.name = '',
    required this.rules,
    required this.logic,
  });
}

class FilterEngine<T> {
  final List<T> data;
  final FilterGroup filterGroup;

  FilterEngine({
    required this.data,
    required this.filterGroup,
  });

  List<T> applyFilters() {
    // Implement filtering logic here
    // This is a placeholder for the actual filtering logic
    return data.where((item) {
      // Apply filters to item
      return true;
    }).toList();
  }
}
