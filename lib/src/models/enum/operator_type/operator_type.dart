part 'date_time_operator.dart';
part 'number_operator.dart';
part 'order_by_operator.dart';
part 'text_operator.dart';

abstract class OperatorType implements Enum {
  String get label => throw UnimplementedError();
}
