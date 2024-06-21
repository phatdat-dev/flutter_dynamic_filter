// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/flutter_dynamic_filter.dart';

import 'base_field.dart';
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
  BaseFieldValue? value;
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
    return FieldAdvancedFilter(
      mustMatch: FilterMustMatch.values.byName(json['mustMatch']),
      field: Field.fromJson(json['field']),
      value: json['value'],
    );
  }

  @override
  FieldAdvancedFilter fromJson(Map<String, dynamic> json) => FieldAdvancedFilter.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['mustMatch'] = mustMatch.name;
    data['field'] = field.toJson();
    data['value'] = value;
    return data;
  }

  // @override
  // List<Object?> get props => [field];
}
