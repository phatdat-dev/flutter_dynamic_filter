// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_dynamic_filter/src/models/enum/field_type.dart';

import 'base_model.dart';

class BaseField extends Equatable {
  final String fieldName;
  final dynamic value;

  const BaseField({
    required this.fieldName,
    required this.value,
  });

  @override
  List<Object?> get props => [fieldName, value];
}

class Field extends BaseField implements SearchDelegateQueryName {
  final FieldType fieldType;

  Field({
    this.fieldType = FieldType.RichText,
    required super.fieldName,
    super.value,
  });

  @override
  String get queryName => fieldName;
  @override
  set queryName(String value) => queryName = value;
  @override
  Object? objectt;

  @override
  List<Object?> get props => [fieldName, value, fieldType];
}
