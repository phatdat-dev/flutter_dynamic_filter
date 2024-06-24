// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/flutter_dynamic_filter.dart';

import 'base_field_value/base_field_value.dart';
import 'base_model.dart';

enum FilterMustMatch {
  and,
  or;

  String get label => switch (this) {
        and => 'And',
        or => 'Or',
      };
}

class FieldAdvancedFilter with ChangeNotifier implements BaseModel<FieldAdvancedFilter> {
  FilterMustMatch mustMatch;
  Field field;

  /// BaseFieldValue || String || Num
  dynamic value;
  //
  late OperatorType operatorType;

  FieldAdvancedFilter({
    this.mustMatch = FilterMustMatch.and,
    required this.field,
    this.value,
  }) {
    operatorType = field.type.defaultType;
  }

  factory FieldAdvancedFilter.fromJson(Map<String, dynamic> json) {
    final data = FieldAdvancedFilter(
      mustMatch: FilterMustMatch.values.byName(json['mustMatch']),
      field: Field.fromJson(json['field']),
    );
    data.setOperatorTypeFromEnumString(json['operatorType']);
    data.setValueFromJson(json['value']);
    return data;
  }

  @override
  FieldAdvancedFilter fromJson(Map<String, dynamic> json) => FieldAdvancedFilter.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mustMatch'] = mustMatch.name;
    data['field'] = field.toJson();
    data['operatorType'] = operatorType.toString();
    data['value'] = value;
    return data;
  }

  // @override
  // List<Object?> get props => [field];

  // TextOperator, OrderByOperator, NumberOperator, DateTimeOperator
  void setOperatorTypeFromEnumString(String? enumString) {
    final operatorTypeString = enumString?.split(".");
    if (operatorTypeString != null) {
      switch (operatorTypeString[0]) {
        case "TextOperator":
          operatorType = TextOperator.values.byName(operatorTypeString[1]);
          break;
        case "OrderByOperator":
          operatorType = OrderByOperator.values.byName(operatorTypeString[1]);
          break;
        case "NumberOperator":
          operatorType = NumberOperator.values.byName(operatorTypeString[1]);
          break;
        case "DateTimeOperator":
          operatorType = DateTimeOperator.values.byName(operatorTypeString[1]);
          break;
        default:
      }
    }
  }

  void setValueFromJson(dynamic json) {
    if (json == null) {
      value = null;
    } else {
      switch (field.type) {
        case FieldType.Text:
          value = json?.toString();
          break;
        case FieldType.Number:
          value = num.tryParse("$json");
          break;
        case FieldType.Date:
          switch (operatorType) {
            case DateTimeOperator.isRelativeToToDay:
              value = RelativeToDayDateFieldValue.fromJson(json);
              break;
            case DateTimeOperator.isBetween:
              value = DateTimeRangeDateFieldValue.fromJson(json);
              break;
            case DateTimeOperator.isEmpty || DateTimeOperator.isNotEmpty:
              value = null;
              break;
            default:
              value = DefaultDateFieldValue.fromJson(json);
              break;
          }
          break;
        default:
      }
    }
  }

  // apply
  bool applyFilters(Map<String, dynamic> json) {
    return operatorType.applyFilters(json[field.name], value);
  }
}
