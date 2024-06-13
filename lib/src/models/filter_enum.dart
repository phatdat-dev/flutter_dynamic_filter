enum FilterOperator {
  iss,
  isNot,
  contains,
  doesNotContain,
  startsWith,
  endsWith,
  isEmpty,
  isNotEmpty,
}

enum FilterDateTimeOperator {
  iss,
  isBefore,
  isAfter,
  isOnOrBefore,
  isOnOrAfter,
  isBetween,
  isNotBetween,
  isRelativeToToDay, // is relative to today
  isEmpty,
  isNotEmpty,
}

enum OrderBy {
  ascending,
  descending,
}
