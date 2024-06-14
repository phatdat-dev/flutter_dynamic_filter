import '../../../generated/flowy_svgs.g.dart';
import '../../shared/widget/flowy_svg.dart';

enum FieldType {
  RichText,
  Number,
  DateTime,
  SingleSelect,
  MultiSelect,
  Checkbox,
  URL,
  Checklist,
  Relation,
  Summary,
}

extension FieldTypeExtension on FieldType {
  // String get i18n => switch (this) {
  //       FieldType.RichText => LocaleKeys.grid_field_textFieldName.tr(),
  //       FieldType.Number => LocaleKeys.grid_field_numberFieldName.tr(),
  //       FieldType.DateTime => LocaleKeys.grid_field_dateFieldName.tr(),
  //       FieldType.SingleSelect =>
  //         LocaleKeys.grid_field_singleSelectFieldName.tr(),
  //       FieldType.MultiSelect =>
  //         LocaleKeys.grid_field_multiSelectFieldName.tr(),
  //       FieldType.Checkbox => LocaleKeys.grid_field_checkboxFieldName.tr(),
  //       FieldType.Checklist => LocaleKeys.grid_field_checklistFieldName.tr(),
  //       FieldType.URL => LocaleKeys.grid_field_urlFieldName.tr(),
  //       FieldType.LastEditedTime =>
  //         LocaleKeys.grid_field_updatedAtFieldName.tr(),
  //       FieldType.CreatedTime => LocaleKeys.grid_field_createdAtFieldName.tr(),
  //       FieldType.Relation => LocaleKeys.grid_field_relationFieldName.tr(),
  //       FieldType.Summary => LocaleKeys.grid_field_summaryFieldName.tr(),
  //       _ => throw UnimplementedError(),
  //     };

  FlowySvgData get svgData => switch (this) {
        FieldType.RichText => FlowySvgs.text_s,
        FieldType.Number => FlowySvgs.number_s,
        FieldType.DateTime => FlowySvgs.date_s,
        FieldType.SingleSelect => FlowySvgs.single_select_s,
        FieldType.MultiSelect => FlowySvgs.multiselect_s,
        FieldType.Checkbox => FlowySvgs.checkbox_s,
        FieldType.URL => FlowySvgs.url_s,
        FieldType.Checklist => FlowySvgs.checklist_s,
        FieldType.Relation => FlowySvgs.relation_s,
        FieldType.Summary => FlowySvgs.ai_summary_s,
      };
}
