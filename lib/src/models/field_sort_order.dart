// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'enum/filter_enum.dart';

class FieldSortOrder extends Equatable {
  String fieldName;
  OrderBy orderBy;

  FieldSortOrder(
    this.fieldName,
    this.orderBy,
  );

  @override
  List<Object?> get props => [fieldName];
}
