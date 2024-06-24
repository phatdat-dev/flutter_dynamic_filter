import 'package:flutter_dynamic_filter/src/shared/extension/app_extension.dart';

import '../../base_field_value/date_field_value.dart';

part 'date_time_operator.dart';
part 'number_operator.dart';
part 'order_by_operator.dart';
part 'text_operator.dart';

abstract class OperatorType<T> implements Enum {
  String get label => throw UnimplementedError();

  bool applyFilters(T? originValue, dynamic filterValue);
}
