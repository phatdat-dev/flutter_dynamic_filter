import '../../../shared/extension/app_extension.dart';
import '../../base_field_value/date_field_value.dart';
import '../../select_option.dart';
import '../../user.dart';

part 'checkbox_operator.dart';
part 'date_time_operator.dart';
part 'number_operator.dart';
part 'order_by_operator.dart';
part 'relation_operator.dart';
part 'select_operator.dart';
part 'text_operator.dart';
part 'user_operator.dart';

abstract class OperatorType<T> implements Enum {
  String get label => throw UnimplementedError();

  bool applyFilters(T? originValue, dynamic filterValue);
}
