// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';

import 'enum/operator_type/operator_type.dart';
import 'field_advanced_filter.dart';
import 'field_sort_order.dart';

class FilterGroup {
  final String name;
  final Iterable<FieldAdvancedFilter> rules;

  FilterGroup({
    this.name = '',
    required this.rules,
  });
}

class FilterEngine {
  final List<Map<String, dynamic>> data;
  final FilterGroup? filterGroup;
  final Set<FieldSortOrder>? sortOrders;

  FilterEngine({
    required this.data,
    this.filterGroup,
    this.sortOrders,
  });

  List<Map<String, dynamic>> applyFilterAndSort() {
    var result = filterList(data);
    result = sortList(result);
    return result;
  }

  List<Map<String, dynamic>> filterList([Iterable<Map<String, dynamic>>? list]) {
    return (list ?? data).where((item) {
      final List<bool> conditions = [];
      for (final rule in filterGroup?.rules ?? <FieldAdvancedFilter>[]) {
        conditions.add(rule.applyFilters(item));

        if (rule.mustMatch == FilterMustMatch.and) {
          // if any of the conditions is false, then the whole rule is false
          if (!conditions.last) break;
        } else if (rule.mustMatch == FilterMustMatch.or) {
          // if any of the conditions is true, then the whole rule is true
          if (conditions.last) break;
        }
      }
      // all true
      return conditions.every((e) => e);
    }).toList();
  }

  List<Map<String, dynamic>> sortList([List<Map<String, dynamic>>? list]) {
    list = List.from(list ??= data);
    if (sortOrders == null) return list;

    list.sort((a, b) => _recursiveSort(a, b, sortOrders!, 0));

    return list;
  }

  int _recursiveSort(Map<String, dynamic> a, Map<String, dynamic> b, Set<FieldSortOrder> sortOrders, int index) {
    if (index >= sortOrders.length) {
      return 0; // All comparators are equal
    }

    final sortOrder = sortOrders.elementAt(index);
    final valueA = a[sortOrder.field.name];
    final valueB = b[sortOrder.field.name];

    int comparison;
    if (valueA is Comparable? && valueB is Comparable?) {
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
