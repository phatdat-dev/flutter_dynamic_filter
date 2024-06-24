import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/src/shared/extension/app_extension.dart';

import '../base_field.dart';
import '../enum/operator_type/operator_type.dart';

abstract class DateFieldValue<T> implements BaseFieldValue<T> {}

class RelativeToDayDateFieldValue extends DateFieldValue<RelativeToDayDateFieldValue> {
  final String relativeTo;
  int relativeToIndex;
  final String unit;
  late final DateTime _now;

  RelativeToDayDateFieldValue({
    required this.relativeTo,
    this.relativeToIndex = 1,
    required this.unit,
  }) {
    _now = DateTime.now();
  }

  List<String> get relativeToList => ["Past", "Next", "This"];
  List<String> get unitList => ["Day", "Week", "Month", "Year"];

  DateTime get value {
    int multiplier = relativeTo == "Past" ? -1 : 1;

    switch (unit) {
      case "Day":
        return relativeTo == "This" ? _now : _now.add(Duration(days: relativeToIndex * multiplier));
      case "Week":
        return relativeTo == "This" ? _now.subtract(Duration(days: _now.weekday - 1)) : _now.add(Duration(days: 7 * relativeToIndex * multiplier));
      case "Month":
        return relativeTo == "This" ? DateTime(_now.year, _now.month, 1) : DateTime(_now.year, _now.month + relativeToIndex * multiplier, _now.day);
      case "Year":
        return relativeTo == "This" ? DateTime(_now.year, 1, 1) : DateTime(_now.year + relativeToIndex * multiplier, _now.month, _now.day);
      default:
        throw Exception("Invalid unit");
    }
  }

  bool isRelativeToToDay(DateTime originValue) {
    switch (_now.compareTo(value)) {
      case -1: // isFuture
        return originValue.isBetween(from: _now, to: value);
      case 1: // isPast
        return originValue.isBetween(from: value, to: _now);
      case 0: // isCurrent
        return originValue.day == value.day && originValue.month == value.month && originValue.year == value.year;
      default:
        return false;
    }
  }

  factory RelativeToDayDateFieldValue.fromJson(Map<String, dynamic> json) => RelativeToDayDateFieldValue(
        relativeTo: json["relativeTo"],
        relativeToIndex: json["relativeToIndex"],
        unit: json["unit"],
      );

  @override
  RelativeToDayDateFieldValue fromJson(Map<String, dynamic> json) => RelativeToDayDateFieldValue.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["relativeTo"] = relativeTo;
    data["relativeToIndex"] = relativeToIndex;
    data["unit"] = unit;
    return data;
  }

  // copyWith
  RelativeToDayDateFieldValue copyWith({
    String? relativeTo,
    int? relativeToIndex,
    String? unit,
  }) {
    return RelativeToDayDateFieldValue(
      relativeTo: relativeTo ?? this.relativeTo,
      relativeToIndex: relativeToIndex ?? this.relativeToIndex,
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
