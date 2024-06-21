part of 'operator_type.dart';

enum DateTimeOperator implements OperatorType {
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
}

enum DateTimeOperatorSelection {
  today,
  yesterday,
  tomorrow,
  oneWeekAgo,
  oneWeekFromNow,
  oneMonthAgo,
  oneMonthFromNow,
  customDate;

  static DateTimeOperatorSelection get defaultType => today;

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
}
