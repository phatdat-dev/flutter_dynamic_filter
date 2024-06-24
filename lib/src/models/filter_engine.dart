// ignore_for_file: must_be_immutable

import 'field_advanced_filter.dart';

class FilterGroup {
  final String name;
  final Iterable<FieldAdvancedFilter> rules;

  FilterGroup({
    this.name = '',
    required this.rules,
  });
}

class FilterEngine {
  final Iterable<Map<String, dynamic>> data;
  final FilterGroup filterGroup;

  FilterEngine({
    required this.data,
    required this.filterGroup,
  });

  List<Map<String, dynamic>> applyFilters() {
    return data.where((item) {
      final List<bool> conditions = [];
      for (final rule in filterGroup.rules) {
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
}
