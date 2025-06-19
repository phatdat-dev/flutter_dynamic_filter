part of 'operator_type.dart';

enum MultiSelectOperator implements OperatorType<List<SelectOption>> {
  contains,
  doesNotContain,
  containsAll,
  isEmpty,
  isNotEmpty;

  @override
  String get label => switch (this) {
    contains => "Contains",
    doesNotContain => "Does not contain",
    containsAll => "Contains all",
    isEmpty => "Is empty",
    isNotEmpty => "Is not empty",
  };

  @override
  bool applyFilters(List<SelectOption>? originValue, dynamic filterValue) {
    switch (this) {
      case MultiSelectOperator.isEmpty:
        return originValue == null || originValue.isEmpty;
      case MultiSelectOperator.isNotEmpty:
        return originValue != null && originValue.isNotEmpty;
      default:
    }

    if (filterValue == null) return true;
    if (originValue == null) return false;

    if (filterValue is SelectOption) {
      switch (this) {
        case MultiSelectOperator.contains:
          return originValue.any((option) => option.id == filterValue.id);
        case MultiSelectOperator.doesNotContain:
          return !originValue.any((option) => option.id == filterValue.id);
        default:
          return false;
      }
    }

    if (filterValue is List<SelectOption>) {
      switch (this) {
        case MultiSelectOperator.contains:
          return filterValue.any((filterOption) => originValue.any((option) => option.id == filterOption.id));
        case MultiSelectOperator.doesNotContain:
          return !filterValue.any((filterOption) => originValue.any((option) => option.id == filterOption.id));
        case MultiSelectOperator.containsAll:
          return filterValue.every((filterOption) => originValue.any((option) => option.id == filterOption.id));
        default:
          return false;
      }
    }

    return false;
  }
}

enum SelectOperator implements OperatorType<SelectOption> {
  iss,
  isNot,
  isEmpty,
  isNotEmpty;

  @override
  String get label => switch (this) {
    iss => "Is",
    isNot => "Is not",
    isEmpty => "Is empty",
    isNotEmpty => "Is not empty",
  };

  @override
  bool applyFilters(SelectOption? originValue, dynamic filterValue) {
    switch (this) {
      case SelectOperator.isEmpty:
        return originValue == null;
      case SelectOperator.isNotEmpty:
        return originValue != null;
      default:
    }

    if (filterValue == null) return true;
    if (originValue == null) return false;

    if (filterValue is SelectOption) {
      switch (this) {
        case SelectOperator.iss:
          return originValue.id == filterValue.id;
        case SelectOperator.isNot:
          return originValue.id != filterValue.id;
        default:
          return false;
      }
    }

    return false;
  }
}
