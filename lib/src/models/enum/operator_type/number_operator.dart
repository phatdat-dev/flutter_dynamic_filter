part of 'operator_type.dart';

enum NumberOperator implements OperatorType {
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
}
