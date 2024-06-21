part of 'operator_type.dart';

enum TextOperator implements OperatorType {
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
}
