import 'package:flutter_dynamic_filter/src/models/enum/field_type.dart';

import 'base_model.dart';

class BaseField {
  final String fieldName;
  final dynamic value;

  BaseField({
    required this.fieldName,
    required this.value,
  });
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
}
