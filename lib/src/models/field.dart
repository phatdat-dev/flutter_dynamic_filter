// ignore_for_file: must_be_immutable

import 'base_field.dart';
import 'base_model.dart';
import 'enum/field_type.dart';

class Field extends BaseField implements SearchDelegateQueryName, BaseModel<Field> {
  final FieldType type;

  Field({
    this.type = FieldType.Text,
    required super.name,
    super.value,
  });

  @override
  String get queryName => name;
  @override
  set queryName(String value) => queryName = value;
  @override
  Object? objectt;

  @override
  List<Object?> get props => [super.props, type];

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      type: FieldType.values.byName(json['type']),
      name: json['name'],
      value: json['value'],
    );
  }

  @override
  Field fromJson(Map<String, dynamic> json) => Field.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type.name;
    data['name'] = name;
    data['value'] = value;
    return data;
  }

  // copyWith
  Field copyWith({
    FieldType? type,
    String? name,
    dynamic value,
  }) {
    return Field(
      type: type ?? this.type,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }
}
