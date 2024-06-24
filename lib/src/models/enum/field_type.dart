import 'package:flutter_dynamic_filter/flutter_dynamic_filter.dart';

import '../../../generated/flowy_svgs.g.dart';
import '../../shared/widget/flowy_svg.dart';

enum FieldType {
  Text,
  Number,
  Date,
  //
  SingleSelect,
  MultiSelect,
  Checkbox;
  // URL,
  // Checklist,
  // Relation,
  // Summary;

  // String get i18n => switch (this) {
  //       FieldType.RichText => LocaleKeys.grid_field_textname.tr(),
  //       FieldType.Number => LocaleKeys.grid_field_numbername.tr(),
  //       FieldType.DateTime => LocaleKeys.grid_field_datename.tr(),
  //       FieldType.SingleSelect =>
  //         LocaleKeys.grid_field_singleSelectname.tr(),
  //       FieldType.MultiSelect =>
  //         LocaleKeys.grid_field_multiSelectname.tr(),
  //       FieldType.Checkbox => LocaleKeys.grid_field_checkboxname.tr(),
  //       FieldType.Checklist => LocaleKeys.grid_field_checklistname.tr(),
  //       FieldType.URL => LocaleKeys.grid_field_urlname.tr(),
  //       FieldType.LastEditedTime =>
  //         LocaleKeys.grid_field_updatedAtname.tr(),
  //       FieldType.CreatedTime => LocaleKeys.grid_field_createdAtname.tr(),
  //       FieldType.Relation => LocaleKeys.grid_field_relationname.tr(),
  //       FieldType.Summary => LocaleKeys.grid_field_summaryname.tr(),
  //       _ => throw UnimplementedError(),
  //     };

  FlowySvgData get svgData => switch (this) {
        Text => FlowySvgs.text_s,
        Number => FlowySvgs.number_s,
        Date => FlowySvgs.date_s,
        SingleSelect => FlowySvgs.single_select_s,
        MultiSelect => FlowySvgs.multiselect_s,
        Checkbox => FlowySvgs.checkbox_s,
        // URL => FlowySvgs.url_s,
        // Checklist => FlowySvgs.checklist_s,
        // Relation => FlowySvgs.relation_s,
        // Summary => FlowySvgs.ai_summary_s,
      };

  List<Object> get operatorType => switch (this) {
        Text => TextOperator.values,
        Number => NumberOperator.values,
        Date => DateTimeOperator.values,
        SingleSelect => TextOperator.values,
        MultiSelect => TextOperator.values,
        Checkbox => TextOperator.values,
      };

  OperatorType get defaultType => switch (this) {
        Text => TextOperator.contains,
        Number => NumberOperator.iss,
        Date => DateTimeOperator.isRelativeToToDay,
        SingleSelect => TextOperator.iss,
        MultiSelect => TextOperator.contains,
        Checkbox => TextOperator.iss,
      };
}
