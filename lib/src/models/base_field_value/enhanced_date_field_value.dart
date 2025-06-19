import 'dart:convert';

import '../base_field.dart';
import '../enum/operator_type/operator_type.dart';

class EnhancedDateFieldValue extends BaseFieldValue<EnhancedDateFieldValue> {
  final DateTimeOperatorSelection operator;
  final int? amount; // For "within past X days" etc.
  final DateTime? customDate;
  final String? unit; // days, weeks, months, years

  EnhancedDateFieldValue({
    required this.operator,
    this.amount,
    this.customDate,
    this.unit,
  });

  factory EnhancedDateFieldValue.fromJson(Map<String, dynamic> json) {
    return EnhancedDateFieldValue(
      operator: DateTimeOperatorSelection.values.byName(json['operator']),
      amount: json['amount'],
      customDate: json['customDate'] != null ? DateTime.parse(json['customDate']) : null,
      unit: json['unit'],
    );
  }

  DateTime get calculatedDate {
    final now = DateTime.now();
    switch (operator) {
      case DateTimeOperatorSelection.today:
        return now;
      case DateTimeOperatorSelection.yesterday:
        return now.subtract(const Duration(days: 1));
      case DateTimeOperatorSelection.tomorrow:
        return now.add(const Duration(days: 1));
      case DateTimeOperatorSelection.thisWeek:
        return now.subtract(Duration(days: now.weekday - 1));
      case DateTimeOperatorSelection.thisMonth:
        return DateTime(now.year, now.month, 1);
      case DateTimeOperatorSelection.thisYear:
        return DateTime(now.year, 1, 1);
      case DateTimeOperatorSelection.nextWeek:
        return now.add(Duration(days: 7 - now.weekday + 1));
      case DateTimeOperatorSelection.nextMonth:
        return DateTime(now.year, now.month + 1, 1);
      case DateTimeOperatorSelection.nextYear:
        return DateTime(now.year + 1, 1, 1);
      case DateTimeOperatorSelection.pastWeek:
        return now.subtract(const Duration(days: 7));
      case DateTimeOperatorSelection.pastMonth:
        return DateTime(now.year, now.month - 1, now.day);
      case DateTimeOperatorSelection.pastYear:
        return DateTime(now.year - 1, now.month, now.day);
      case DateTimeOperatorSelection.withinPastDays:
        return now.subtract(Duration(days: amount ?? 0));
      case DateTimeOperatorSelection.withinNextDays:
        return now.add(Duration(days: amount ?? 0));
      case DateTimeOperatorSelection.withinPastWeeks:
        return now.subtract(Duration(days: (amount ?? 0) * 7));
      case DateTimeOperatorSelection.withinNextWeeks:
        return now.add(Duration(days: (amount ?? 0) * 7));
      case DateTimeOperatorSelection.withinPastMonths:
        return DateTime(now.year, now.month - (amount ?? 0), now.day);
      case DateTimeOperatorSelection.withinNextMonths:
        return DateTime(now.year, now.month + (amount ?? 0), now.day);
      case DateTimeOperatorSelection.customDate:
        return customDate ?? now;
      default:
        return now;
    }
  }

  EnhancedDateFieldValue copyWith({
    DateTimeOperatorSelection? operator,
    int? amount,
    DateTime? customDate,
    String? unit,
  }) {
    return EnhancedDateFieldValue(
      operator: operator ?? this.operator,
      amount: amount ?? this.amount,
      customDate: customDate ?? this.customDate,
      unit: unit ?? this.unit,
    );
  }

  @override
  EnhancedDateFieldValue fromJson(Map<String, dynamic> json) => EnhancedDateFieldValue.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'operator': operator.name,
      'amount': amount,
      'customDate': customDate?.toIso8601String(),
      'unit': unit,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
