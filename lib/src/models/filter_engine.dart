// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';

import 'enum/operator_type/operator_type.dart';
import 'field_advanced_filter.dart';
import 'field_sort_order.dart';

class FilterEngine<T> {
  /// Your data
  final List<T> data;

  /// Function to extract value from object by field name
  final dynamic Function(T item, String fieldName) valueExtractor;

  /// FilterGroup to apply to the data
  final FilterGroup? filterGroup;

  /// SortOrders to apply to the data
  final Set<FieldSortOrder>? sortOrders;

  FilterEngine({
    required this.data,
    required this.valueExtractor,
    this.filterGroup,
    this.sortOrders,
  });

  /// Legacy constructor for Map\<String, dynamic\> compatibility
  FilterEngine.fromMap({
    required List<Map<String, dynamic>> data,
    FilterGroup? filterGroup,
    Set<FieldSortOrder>? sortOrders,
  }) : this(
         data: List.from(data),
         valueExtractor: (item, fieldName) => (item as Map<String, dynamic>)[fieldName],
         filterGroup: filterGroup,
         sortOrders: sortOrders,
       );

  /// Apply the filter and sort to the data
  List<T> applyFilterAndSort() {
    var result = filterList(data);
    result = sortList(result);
    return result;
  }

  /// Only apply the filter to the data
  List<T> filterList([Iterable<T>? list]) {
    return (list ?? data).where((item) {
      return _evaluateFilterGroup(filterGroup, item);
    }).toList();
  }

  /// Only apply the sort to the data
  List<T> sortList([List<T>? list]) {
    list = List.from(list ??= data);
    if (sortOrders == null) return list;

    list.sort((a, b) => _recursiveSort(a, b, sortOrders!, 0));

    return list;
  }

  /// Evaluate a filter group against an item
  bool _evaluateFilterGroup(FilterGroup? group, T item) {
    if (group == null) return true;

    final ruleResults = <bool>[];
    final subGroupResults = <bool>[];

    // Evaluate field rules
    for (final rule in group.rules) {
      final fieldValue = valueExtractor(item, rule.field.name);
      ruleResults.add(rule.applyFilters(fieldValue));
    }

    // Evaluate sub groups
    for (final subGroup in group.subGroups) {
      subGroupResults.add(_evaluateFilterGroup(subGroup, item));
    }

    final allResults = [...ruleResults, ...subGroupResults];
    if (allResults.isEmpty) return true;

    // Apply logic
    switch (group.mustMatch) {
      case FilterMustMatch.and:
        return allResults.every((result) => result);
      case FilterMustMatch.or:
        return allResults.any((result) => result);
    }
  }

  int _recursiveSort(
    T a,
    T b,
    Set<FieldSortOrder> sortOrders,
    int index,
  ) {
    if (index >= sortOrders.length) {
      return 0; // All comparators are equal
    }

    final sortOrder = sortOrders.elementAt(index);
    final valueA = valueExtractor(a, sortOrder.field.name) ?? '';
    final valueB = valueExtractor(b, sortOrder.field.name) ?? '';

    int comparison;
    if (valueA is Comparable && valueB is Comparable) {
      comparison = compareNatural(valueA.toString(), valueB.toString());
    } else {
      comparison = 0;
    }

    if (sortOrder.orderBy == OrderByOperator.descending) {
      comparison = -comparison;
    }

    if (comparison != 0) {
      return comparison;
    }

    // Recursively call the next comparator
    return _recursiveSort(a, b, sortOrders, index + 1);
  }
}

class FilterGroup {
  /// Name of the group
  final String name;

  /// Logic to combine rules (AND/OR)
  final FilterMustMatch mustMatch;

  /// List of field filters to apply
  final List<FieldAdvancedFilter> rules;

  /// Nested filter groups
  final List<FilterGroup> subGroups;

  FilterGroup({
    this.name = '',
    this.mustMatch = FilterMustMatch.and,
    this.rules = const [],
    this.subGroups = const [],
  });

  factory FilterGroup.fromJson(Map<String, dynamic> json) {
    return FilterGroup(
      name: json['name'] ?? '',
      mustMatch: FilterMustMatch.values.byName(json['mustMatch'] ?? 'and'),
      rules: (json['rules'] as List?)?.map((r) => FieldAdvancedFilter.fromJson(r)).toList() ?? [],
      subGroups: (json['subGroups'] as List?)?.map((g) => FilterGroup.fromJson(g)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mustMatch': mustMatch.name,
      'rules': rules.map((r) => r.toJson()).toList(),
      'subGroups': subGroups.map((g) => g.toJson()).toList(),
    };
  }
}
