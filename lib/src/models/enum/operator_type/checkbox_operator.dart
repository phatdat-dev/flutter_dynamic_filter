part of 'operator_type.dart';

enum CheckboxOperator implements OperatorType<bool> {
  isChecked,
  isNotChecked;

  @override
  String get label => switch (this) {
    isChecked => "Is checked",
    isNotChecked => "Is not checked",
  };

  @override
  bool applyFilters(bool? originValue, dynamic filterValue) {
    switch (this) {
      case CheckboxOperator.isChecked:
        return originValue == true;
      case CheckboxOperator.isNotChecked:
        return originValue != true;
    }
  }
}
