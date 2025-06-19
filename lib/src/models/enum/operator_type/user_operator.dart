part of 'operator_type.dart';

enum UserOperator implements OperatorType<User> {
  iss,
  isNot,
  contains,
  doesNotContain,
  isCurrentUser,
  isNotCurrentUser,
  isEmpty,
  isNotEmpty;

  @override
  String get label => switch (this) {
    iss => "Is",
    isNot => "Is not",
    contains => "Contains",
    doesNotContain => "Does not contain",
    isCurrentUser => "Is current user",
    isNotCurrentUser => "Is not current user",
    isEmpty => "Is empty",
    isNotEmpty => "Is not empty",
  };

  @override
  bool applyFilters(User? originValue, dynamic filterValue) {
    switch (this) {
      case UserOperator.isEmpty:
        return originValue == null;
      case UserOperator.isNotEmpty:
        return originValue != null;
      case UserOperator.isCurrentUser:
        return originValue?.isCurrentUser ?? false;
      case UserOperator.isNotCurrentUser:
        return !(originValue?.isCurrentUser ?? false);
      default:
    }

    if (filterValue == null) return true;
    if (originValue == null) return false;

    if (filterValue is User) {
      switch (this) {
        case UserOperator.iss:
          return originValue.id == filterValue.id;
        case UserOperator.isNot:
          return originValue.id != filterValue.id;
        case UserOperator.contains:
          return originValue.name.toLowerCase().contains(filterValue.name.toLowerCase()) ||
              originValue.email.toLowerCase().contains(filterValue.email.toLowerCase());
        case UserOperator.doesNotContain:
          return !originValue.name.toLowerCase().contains(filterValue.name.toLowerCase()) &&
              !originValue.email.toLowerCase().contains(filterValue.email.toLowerCase());
        default:
          return false;
      }
    }

    return false;
  }
}
