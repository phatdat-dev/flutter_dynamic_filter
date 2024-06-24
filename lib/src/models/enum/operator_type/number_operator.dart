part of 'operator_type.dart';

enum NumberOperator implements OperatorType<num> {
  iss,
  isNot,
  isGreaterThan,
  isGreaterThanOrEqual,
  isLessThan,
  isLessThanOrEqual,
  isEmpty,
  isNotEmpty;

  @override
  String get label => switch (this) {
        iss => "=",
        isNot => "!=",
        isGreaterThan => ">",
        isGreaterThanOrEqual => ">=",
        isLessThan => "<",
        isLessThanOrEqual => "<=",
        isEmpty => "Is empty",
        isNotEmpty => "Is not empty",
      };

  @override
  bool applyFilters(num? originValue, dynamic filterValue) {
    if (filterValue == null) return true;

    return switch (this) {
      iss => originValue == filterValue,
      isNot => originValue != filterValue,
      isGreaterThan => originValue! > filterValue,
      isGreaterThanOrEqual => originValue! >= filterValue,
      isLessThan => originValue! < filterValue,
      isLessThanOrEqual => originValue! <= filterValue,
      isEmpty => originValue == null,
      isNotEmpty => originValue != null,
    };
  }
}
