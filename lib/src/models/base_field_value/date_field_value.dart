import 'dart:convert';

import 'package:flutter/material.dart';

import '../base_field.dart';
import '../enum/operator_type/operator_type.dart';

abstract class DateFieldValue<T> implements BaseFieldValue<T> {}

class RelativeToDayDateFieldValue extends DateFieldValue<RelativeToDayDateFieldValue> {
  final String relativeTo;
  final String unit;

  RelativeToDayDateFieldValue({
    required this.relativeTo,
    required this.unit,
  });

  factory RelativeToDayDateFieldValue.fromJson(Map<String, dynamic> json) => RelativeToDayDateFieldValue(
        relativeTo: json["relativeTo"],
        unit: json["unit"],
      );

  @override
  RelativeToDayDateFieldValue fromJson(Map<String, dynamic> json) => RelativeToDayDateFieldValue.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["relativeTo"] = relativeTo;
    data["unit"] = unit;
    return data;
  }

  // copyWith
  RelativeToDayDateFieldValue copyWith({
    String? relativeTo,
    String? unit,
  }) {
    return RelativeToDayDateFieldValue(
      relativeTo: relativeTo ?? this.relativeTo,
      unit: unit ?? this.unit,
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}

class DefaultDateFieldValue extends DateFieldValue<DefaultDateFieldValue> {
  final DateTimeOperatorSelection operator;
  final DateTime value;

  DefaultDateFieldValue({
    required this.operator,
    required this.value,
  });

  factory DefaultDateFieldValue.fromJson(Map<String, dynamic> json) => DefaultDateFieldValue(
        operator: DateTimeOperatorSelection.values.byName(json["operator"]),
        value: DateTime.parse(json["value"]),
      );

  @override
  DefaultDateFieldValue fromJson(Map<String, dynamic> json) => DefaultDateFieldValue.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["operator"] = operator.name;
    data["value"] = value.toIso8601String();
    return data;
  }

  // copyWith
  DefaultDateFieldValue copyWith({
    DateTimeOperatorSelection? operator,
    DateTime? value,
  }) {
    return DefaultDateFieldValue(
      operator: operator ?? this.operator,
      value: value ?? this.value,
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}

class DateTimeRangeDateFieldValue extends DateFieldValue<DateTimeRangeDateFieldValue> {
  final DateTimeRange dateTimeRange;

  DateTimeRangeDateFieldValue({
    required this.dateTimeRange,
  });

  factory DateTimeRangeDateFieldValue.fromJson(Map<String, dynamic> json) => DateTimeRangeDateFieldValue(
        dateTimeRange: DateTimeRange(
          start: DateTime.parse(json["start"]),
          end: DateTime.parse(json["end"]),
        ),
      );

  @override
  DateTimeRangeDateFieldValue fromJson(Map<String, dynamic> json) => DateTimeRangeDateFieldValue.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["start"] = dateTimeRange.start.toIso8601String();
    data["end"] = dateTimeRange.end.toIso8601String();
    return data;
  }

  // copyWith
  DateTimeRangeDateFieldValue copyWith({
    DateTimeRange? dateTimeRange,
  }) {
    return DateTimeRangeDateFieldValue(
      dateTimeRange: dateTimeRange ?? this.dateTimeRange,
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}
