import '../../../flutter_dynamic_filter.dart';
import '../../../generated/flowy_svgs.g.dart';
import '../../shared/widget/flowy_svg.dart';

enum FieldType {
  Text,
  Number,
  Date,
  SingleSelect,
  MultiSelect,
  Checkbox,
  User,
  CreatedBy,
  LastEditedBy,
  Relation,
  Status,
  URL,
  Email,
  Phone;

  OperatorType get defaultType => switch (this) {
    Text || URL || Email || Phone => TextOperator.contains,
    Number => NumberOperator.iss,
    Date => DateTimeOperator.isRelativeToToDay,
    SingleSelect || Status => SelectOperator.iss,
    MultiSelect => MultiSelectOperator.contains,
    Checkbox => CheckboxOperator.isChecked,
    User || CreatedBy || LastEditedBy => UserOperator.iss,
    Relation => RelationOperator.contains,
  };

  List<Object> get operatorType => switch (this) {
    Text || URL || Email || Phone => TextOperator.values,
    Number => NumberOperator.values,
    Date => DateTimeOperator.values,
    SingleSelect || Status => SelectOperator.values,
    MultiSelect => MultiSelectOperator.values,
    Checkbox => CheckboxOperator.values,
    User || CreatedBy || LastEditedBy => UserOperator.values,
    Relation => RelationOperator.values,
  };

  FlowySvgData get svgData => switch (this) {
    Text => FlowySvgs.text_s,
    Number => FlowySvgs.number_s,
    Date => FlowySvgs.date_s,
    SingleSelect => FlowySvgs.single_select_s,
    MultiSelect => FlowySvgs.multiselect_s,
    Checkbox => FlowySvgs.checkbox_s,
    User || CreatedBy || LastEditedBy => FlowySvgs.text_s,
    Relation => FlowySvgs.relation_s,
    Status => FlowySvgs.single_select_s,
    URL => FlowySvgs.url_s,
    Email || Phone => FlowySvgs.text_s,
  };
}
