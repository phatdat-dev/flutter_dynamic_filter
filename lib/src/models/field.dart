import 'package:flutter/material.dart';

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
  final IconData? icon;

  Field({
    this.icon,
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
