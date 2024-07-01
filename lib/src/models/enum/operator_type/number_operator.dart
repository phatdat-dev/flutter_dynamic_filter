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
    // xét 2 cái này trước
    switch (this) {
      case NumberOperator.isEmpty:
        return originValue == null;
      case NumberOperator.isNotEmpty:
        return originValue != null;
      default:
    }
    // nếu là các lựa chọn còn lại thì cho phép ô nhập filterValue được rỗng -> sẽ lấy tất cả data
    if (filterValue == null) return true;

    return switch (this) {
      iss => originValue == filterValue,
      isNot => originValue != filterValue,
      isGreaterThan => originValue! > filterValue,
      isGreaterThanOrEqual => originValue! >= filterValue,
      isLessThan => originValue! < filterValue,
      isLessThanOrEqual => originValue! <= filterValue,
      isEmpty => originValue == null, // ignore
      isNotEmpty => originValue != null, // ignore
    };
  }
}
