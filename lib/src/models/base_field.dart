// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:flutter_dynamic_filter/src/models/base_model.dart';

class BaseField extends Equatable {
  final String name;
  BaseFieldValue? value;

  BaseField({
    required this.name,
    required this.value,
  });

  @override
  List<Object?> get props => [name, value];
}

abstract class BaseFieldValue<T> implements BaseModel<T> {}
