// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../flutter_dynamic_filter.dart';
import 'base_field.dart';
import 'base_field_value/base_field_value.dart';
import 'base_model.dart';

class FieldAdvancedFilter with ChangeNotifier implements BaseModel<FieldAdvancedFilter> {
  FilterMustMatch mustMatch;
  Field field;

  /// BaseFieldValue || String || Num || User || SelectOption || List\<SelectOption\> || bool
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

  // apply
  bool applyFilters(dynamic jsonValue) {
    final data = _extractFieldValue(jsonValue);
    return operatorType.applyFilters(data, value);
  }

  //copyWith
  FieldAdvancedFilter copyWith({
    FilterMustMatch? mustMatch,
    Field? field,
    dynamic value,
  }) {
    return FieldAdvancedFilter(
      mustMatch: mustMatch ?? this.mustMatch,
      field: field ?? this.field.copyWith(),
      value: value ?? this.value,
    );
  }

  @override
  FieldAdvancedFilter fromJson(Map<String, dynamic> json) => FieldAdvancedFilter.fromJson(json);

  // TextOperator, OrderByOperator, NumberOperator, DateTimeOperator, UserOperator, etc.
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
        case "UserOperator":
          operatorType = UserOperator.values.byName(operatorTypeString[1]);
          break;
        case "RelationOperator":
          operatorType = RelationOperator.values.byName(operatorTypeString[1]);
          break;
        case "SelectOperator":
          operatorType = SelectOperator.values.byName(operatorTypeString[1]);
          break;
        case "MultiSelectOperator":
          operatorType = MultiSelectOperator.values.byName(operatorTypeString[1]);
          break;
        case "CheckboxOperator":
          operatorType = CheckboxOperator.values.byName(operatorTypeString[1]);
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
        case FieldType.URL:
        case FieldType.Email:
        case FieldType.Phone:
          value = json?.toString();
          break;
        case FieldType.Number:
          value = num.tryParse("$json");
          break;
        case FieldType.Checkbox:
          value = json is bool ? json : (json.toString().toLowerCase() == 'true');
          break;
        case FieldType.User:
        case FieldType.CreatedBy:
        case FieldType.LastEditedBy:
          if (json is Map<String, dynamic>) {
            value = User.fromJson(json);
          }
          break;
        case FieldType.SingleSelect:
        case FieldType.Status:
          if (json is Map<String, dynamic>) {
            value = SelectOption.fromJson(json);
          }
          break;
        case FieldType.MultiSelect:
          if (json is List) {
            value = json.map((e) => SelectOption.fromJson(e)).toList();
          }
          break;
        case FieldType.Relation:
          if (json is List) {
            value = List<String>.from(json);
          }
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
      }
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mustMatch'] = mustMatch.name;
    data['field'] = field.toJson();
    data['operatorType'] = operatorType.toString();
    data['value'] = _valueToJson();
    return data;
  }

  dynamic _convertValueByFieldType(dynamic rawValue) {
    if (rawValue == null) return null;

    switch (field.type) {
      case FieldType.Date:
        // allow String is DateTime iso8601
        DateTime? tryParseDateTime;
        try {
          tryParseDateTime = DateTime.tryParse(rawValue.toString());
        } catch (e) {}
        return tryParseDateTime ?? rawValue;

      case FieldType.User:
      case FieldType.CreatedBy:
      case FieldType.LastEditedBy:
        if (rawValue is Map<String, dynamic>) {
          return User.fromJson(rawValue);
        } else if (rawValue is User) {
          return rawValue;
        }
        break;

      case FieldType.SingleSelect:
      case FieldType.Status:
        if (rawValue is Map<String, dynamic>) {
          return SelectOption.fromJson(rawValue);
        } else if (rawValue is SelectOption) {
          return rawValue;
        }
        break;

      case FieldType.MultiSelect:
        if (rawValue is List) {
          return rawValue
              .map((e) {
                if (e is Map<String, dynamic>) {
                  return SelectOption.fromJson(e);
                } else if (e is SelectOption) {
                  return e;
                }
                return null;
              })
              .where((e) => e != null)
              .cast<SelectOption>()
              .toList();
        }
        break;

      case FieldType.Relation:
        if (rawValue is List) {
          return List<String>.from(rawValue);
        }
        break;

      case FieldType.Checkbox:
        if (rawValue is bool) return rawValue;
        return rawValue.toString().toLowerCase() == 'true';

      case FieldType.Number:
        if (rawValue is num) return rawValue;
        return num.tryParse(rawValue.toString());

      default:
        return rawValue;
    }

    return rawValue;
  }

  dynamic _extractFieldValue(dynamic jsonValue) {
    if (jsonValue is Map<String, dynamic>) {
      final rawValue = jsonValue[field.name];
      return _convertValueByFieldType(rawValue);
    }
    return _convertValueByFieldType(jsonValue);
  }

  dynamic _valueToJson() {
    if (value == null) return null;

    switch (field.type) {
      case FieldType.User:
      case FieldType.CreatedBy:
      case FieldType.LastEditedBy:
        if (value is User) return (value as User).toJson();
        break;
      case FieldType.SingleSelect:
      case FieldType.Status:
        if (value is SelectOption) return (value as SelectOption).toJson();
        break;
      case FieldType.MultiSelect:
        if (value is List<SelectOption>) {
          return (value as List<SelectOption>).map((e) => e.toJson()).toList();
        }
        break;
      case FieldType.Relation:
        if (value is List<String>) return value;
        break;
      case FieldType.Date:
        if (value is BaseFieldValue) return (value as BaseFieldValue).toJson();
        break;
      default:
        return value;
    }
    return value;
  }
}

enum FilterMustMatch {
  and,
  or;

  String get label => switch (this) {
    and => 'And',
    or => 'Or',
  };
}
