// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'enum/operator_type/operator_type.dart';
import 'field.dart';

class FieldSortOrder extends Equatable {
  Field field;
  OrderByOperator orderBy;

  FieldSortOrder(
    this.field,
    this.orderBy,
  );

  @override
  List<Object?> get props => [field.name];
}
