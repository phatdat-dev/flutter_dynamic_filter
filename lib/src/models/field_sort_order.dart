// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter_dynamic_filter/src/models/field.dart';

import 'enum/filter_enum.dart';

class FieldSortOrder extends Equatable {
  Field field;
  OrderBy orderBy;

  FieldSortOrder(
    this.field,
    this.orderBy,
  );

  @override
  List<Object?> get props => [field.fieldName];
}
