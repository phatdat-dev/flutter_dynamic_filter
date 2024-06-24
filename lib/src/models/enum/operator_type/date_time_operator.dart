part of 'operator_type.dart';

enum DateTimeOperator implements OperatorType<DateTime> {
  iss,
  isBefore,
  isAfter,
  isOnOrBefore,
  isOnOrAfter,
  isBetween,
  isRelativeToToDay,
  isEmpty,
  isNotEmpty;

  @override
  String get label => switch (this) {
        iss => "Is",
        isBefore => "Is Before",
        isAfter => "Is After",
        isOnOrBefore => "Is On or Before",
        isOnOrAfter => "Is On or After",
        isBetween => "Is Between",
        isRelativeToToDay => "Is Relative to Today",
        isEmpty => "Is Empty",
        isNotEmpty => "Is Not Empty",
      };
  @override
  bool applyFilters(DateTime? originValue, dynamic filterValue) {
    return switch (this) {
      iss => originValue == filterValue,
      isBefore => originValue?.isBefore(filterValue) ?? false,
      isAfter => originValue?.isAfter(filterValue) ?? false,
      isOnOrBefore => (originValue?.isBefore(filterValue) ?? false) || (originValue?.isAtSameMomentAs(filterValue) ?? false),
      isOnOrAfter => (originValue?.isAfter(filterValue) ?? false) || (originValue?.isAtSameMomentAs(filterValue) ?? false),
      isBetween => _getIsBetween(originValue, filterValue),
      isRelativeToToDay => _getIsRelativeToToDay(originValue, filterValue),
      isEmpty => originValue == null,
      isNotEmpty => originValue != null,
    };
  }

  bool _getIsBetween(DateTime? originValue, DateTimeRangeDateFieldValue filterValue) {
    return originValue?.isBetween(from: filterValue.dateTimeRange.start, to: filterValue.dateTimeRange.end) ?? false;
  }

  bool _getIsRelativeToToDay(DateTime? originValue, RelativeToDayDateFieldValue filterValue) {
    return originValue != null ? (filterValue).isRelativeToToDay(originValue) : false;
  }
}

enum DateTimeOperatorSelection implements OperatorType<DateTime> {
  today,
  yesterday,
  tomorrow,
  oneWeekAgo,
  oneWeekFromNow,
  oneMonthAgo,
  oneMonthFromNow,
  customDate;

  static DateTimeOperatorSelection get defaultType => today;

  @override
  String get label => switch (this) {
        today => "Today",
        yesterday => "Yesterday",
        tomorrow => "Tomorrow",
        oneWeekAgo => "One Week Ago",
        oneWeekFromNow => "One Week From Now",
        oneMonthAgo => "One Month Ago",
        oneMonthFromNow => "One Month From Now",
        customDate => "Custom Date",
      };

  DateTime get value {
    final now = DateTime.now();
    switch (this) {
      case today:
        return now;
      case yesterday:
        return now.subtract(const Duration(days: 1));
      case tomorrow:
        return now.add(const Duration(days: 1));
      case oneWeekAgo:
        return now.subtract(const Duration(days: 7));
      case oneWeekFromNow:
        return now.add(const Duration(days: 7));
      case oneMonthAgo:
        return now.subtract(const Duration(days: 30));
      case oneMonthFromNow:
        return now.add(const Duration(days: 30));
      case customDate:
        return now;
    }
  }

  @override
  bool applyFilters(DateTime? originValue, dynamic filterValue) {
    if (filterValue == null) return true;
    return originValue?.isAtSameMomentAs(filterValue) ?? false;
  }
}
