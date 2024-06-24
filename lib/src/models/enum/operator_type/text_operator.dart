part of 'operator_type.dart';

enum TextOperator implements OperatorType<String> {
  iss,
  isNot,
  contains,
  doesNotContain,
  startsWith,
  endsWith,
  isEmpty,
  isNotEmpty;

  @override
  String get label => switch (this) {
        iss => "Is",
        isNot => "Is not",
        contains => "Contains",
        doesNotContain => "Does not contain",
        startsWith => "Starts with",
        endsWith => "Ends with",
        isEmpty => "Is empty",
        isNotEmpty => "Is not empty",
      };

  @override
  bool applyFilters(String? originValue, dynamic filterValue) {
    if (filterValue == null) return true;
    originValue = originValue?.toLowerCase();
    filterValue = filterValue.toString().toLowerCase();

    return switch (this) {
      iss => originValue == filterValue,
      isNot => originValue != filterValue,
      contains => originValue?.contains(filterValue) ?? false,
      doesNotContain => !(originValue?.contains(filterValue) ?? false),
      startsWith => originValue?.startsWith(filterValue) ?? false,
      endsWith => originValue?.endsWith(filterValue) ?? false,
      isEmpty => originValue == null,
      isNotEmpty => originValue != null,
    };
  }
}
