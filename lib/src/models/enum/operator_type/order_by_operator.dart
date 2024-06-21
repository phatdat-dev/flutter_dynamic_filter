part of 'operator_type.dart';

enum OrderByOperator implements OperatorType {
  ascending,
  descending;

  @override
  String get label => switch (this) {
        ascending => "Ascending",
        descending => "Descending",
      };
}
