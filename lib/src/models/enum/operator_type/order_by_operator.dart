part of 'operator_type.dart';

enum OrderByOperator implements OperatorType<Object> {
  ascending,
  descending;

  @override
  String get label => switch (this) {
        ascending => "Ascending",
        descending => "Descending",
      };

  @override
  bool applyFilters(Object? originValue, dynamic filterValue) {
    return true;
  }
}
