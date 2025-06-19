part of 'operator_type.dart';

enum RelationOperator implements OperatorType<List<String>> {
  contains,
  doesNotContain,
  containsCurrentPage,
  isEmpty,
  isNotEmpty;

  @override
  String get label => switch (this) {
    contains => "Contains",
    doesNotContain => "Does not contain",
    containsCurrentPage => "Contains current page",
    isEmpty => "Is empty",
    isNotEmpty => "Is not empty",
  };

  @override
  bool applyFilters(List<String>? originValue, dynamic filterValue) {
    switch (this) {
      case RelationOperator.isEmpty:
        return originValue == null || originValue.isEmpty;
      case RelationOperator.isNotEmpty:
        return originValue != null && originValue.isNotEmpty;
      case RelationOperator.containsCurrentPage:
        if (filterValue is String) {
          return originValue?.contains(filterValue) ?? false;
        }
        return false;
      default:
    }

    if (filterValue == null) return true;
    if (originValue == null) return false;

    if (filterValue is String) {
      switch (this) {
        case RelationOperator.contains:
          return originValue.contains(filterValue);
        case RelationOperator.doesNotContain:
          return !originValue.contains(filterValue);
        default:
          return false;
      }
    }

    if (filterValue is List<String>) {
      switch (this) {
        case RelationOperator.contains:
          return filterValue.any((id) => originValue.contains(id));
        case RelationOperator.doesNotContain:
          return !filterValue.any((id) => originValue.contains(id));
        default:
          return false;
      }
    }

    return false;
  }
}
