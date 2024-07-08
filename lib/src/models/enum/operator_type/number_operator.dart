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

    if (originValue != null) {
      switch (this) {
        case NumberOperator.isGreaterThan:
          return originValue > filterValue;
        case NumberOperator.isGreaterThanOrEqual:
          return originValue >= filterValue;
        case NumberOperator.isLessThan:
          return originValue < filterValue;
        case NumberOperator.isLessThanOrEqual:
          return originValue <= filterValue;
        default:
      }
    }

    switch (this) {
      case NumberOperator.iss:
        return originValue == filterValue;
      case NumberOperator.isNot:
        return originValue != filterValue;
      default:
    }
    return false;
  }
}
