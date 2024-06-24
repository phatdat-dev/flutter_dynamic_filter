// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

part of '../../advanced_filter_button.dart';

class DateOperatorTypeFilterEditorItemButton extends StatefulWidget {
  const DateOperatorTypeFilterEditorItemButton({super.key});

  @override
  State<DateOperatorTypeFilterEditorItemButton> createState() => _DateOperatorTypeFilterEditorItemButtonState();
}

class _DateOperatorTypeFilterEditorItemButtonState extends State<DateOperatorTypeFilterEditorItemButton> with FieldAdvancedFilterItemStateMixin {
  String formatDate(DateTime date) => DateFormat.yMd().format(date);

  @override
  Widget build(BuildContext context) {
    final Widget child;
    switch (item.operatorType) {
      case DateTimeOperator.isRelativeToToDay:
        child = buildIsRelativeToDay();
      case DateTimeOperator.isBetween:
        child = buildIsBetween();
      case DateTimeOperator.isEmpty || DateTimeOperator.isNotEmpty:
        item.value = null;
        child = const SizedBox();
      default:
        child = buildDefaultSelection();
    }
    Printt.white("${context.read<int>()} - ${item.operatorType} - ${item.value?.toJson()}");
    return child;
  }

  Widget buildDefaultSelection() {
    final dateFieldValue = ((item.value is DefaultDateFieldValue) ? item.value : null) as DefaultDateFieldValue?;
    item.value = DefaultDateFieldValue(
      operator: dateFieldValue?.operator ?? DateTimeOperatorSelection.defaultType,
      value: dateFieldValue?.value ?? DateTimeOperatorSelection.defaultType.value,
    );

    final operatorSelection = ValueNotifier<DateTimeOperatorSelection>((item.value as DefaultDateFieldValue).operator);
    return ValueListenableBuilder(
      valueListenable: operatorSelection,
      builder: (context, value, child) {
        return Row(
          children: [
            Expanded(
              child: MyOutlinedButton(
                label: Text(value.label),
                onPressed: () async {
                  HelperWidget.showPopupMenu(
                    context: context,
                    items: DateTimeOperatorSelection.values
                        .map(
                          (e) => HelperWidget.popupMenuItemCheck(
                            context: context,
                            value: e,
                            selected: value,
                            label: e.label,
                            onTap: () {
                              operatorSelection.value = e;
                              item.value = DefaultDateFieldValue(
                                operator: e,
                                value: e.value,
                              );
                            },
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
            if (value == DateTimeOperatorSelection.customDate) ...[
              const SizedBox(width: MyConstants.paddingField),
              Expanded(
                child: Builder(builder: (context) {
                  final dateSelected = ValueNotifier((item.value as DefaultDateFieldValue).value);
                  return ValueListenableBuilder(
                    valueListenable: dateSelected,
                    builder: (context, value, child) {
                      return MyOutlinedButton(
                        label: Text(formatDate(value)),
                        onPressed: () async {
                          final result = await showDatePicker(
                            context: context,
                            initialDate: value,
                            firstDate: DateTime(1970),
                            lastDate: DateTime(2100),
                          );
                          if (result != null) {
                            dateSelected.value = result;
                            item.value = (item.value as DefaultDateFieldValue).copyWith(
                              value: result,
                            );
                          }
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget buildIsRelativeToDay() {
    final dateFieldValue = ((item.value is RelativeToDayDateFieldValue) ? item.value : null) as RelativeToDayDateFieldValue?;
    item.value = RelativeToDayDateFieldValue(
      relativeTo: dateFieldValue?.relativeTo ?? "This",
      unit: dateFieldValue?.unit ?? "Day",
    );

    final list1 = ["Past", "Next", "This"];
    final selected1 = ValueNotifier((item.value as RelativeToDayDateFieldValue).relativeTo);
    final list2 = ["Day", "Week", "Month", "Year"];
    final selected2 = ValueNotifier((item.value as RelativeToDayDateFieldValue).unit);

    Widget buildButton(List<String> list, ValueNotifier<String> current, ValueChanged<String> onChanged) {
      return ValueListenableBuilder(
        valueListenable: current,
        builder: (context, value, child) => MyOutlinedButton(
          label: Text(value),
          onPressed: () async {
            HelperWidget.showPopupMenu(
              context: context,
              items: list
                  .map(
                    (e) => HelperWidget.popupMenuItemCheck(
                      context: context,
                      value: e,
                      selected: value,
                      label: e,
                      onTap: () {
                        current.value = e;
                        onChanged(e);
                      },
                    ),
                  )
                  .toList(),
            );
          },
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: buildButton(
            list1,
            selected1,
            (value) {
              item.value = (item.value as RelativeToDayDateFieldValue).copyWith(relativeTo: value);
            },
          ),
        ),
        const SizedBox(width: MyConstants.paddingField),
        Expanded(
          child: buildButton(
            list2,
            selected2,
            (value) {
              item.value = (item.value as RelativeToDayDateFieldValue).copyWith(unit: value);
            },
          ),
        ),
      ],
    );
  }

  Widget buildIsBetween() {
    final dateFieldValue = ((item.value is DateTimeRangeDateFieldValue) ? item.value : null) as DateTimeRangeDateFieldValue?;
    item.value = DateTimeRangeDateFieldValue(
      dateTimeRange: dateFieldValue?.dateTimeRange ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now(),
          ),
    );
    final dateSelected = ValueNotifier<DateTimeRange>((item.value as DateTimeRangeDateFieldValue).dateTimeRange);

    return ValueListenableBuilder(
      valueListenable: dateSelected,
      builder: (context, value, child) => MyOutlinedButton(
        label: Text("${formatDate(value.start)} - ${formatDate(value.end)}"),
        onPressed: () async {
          final result = await showDateRangePicker(
            context: context,
            initialDateRange: value,
            firstDate: DateTime(1970),
            lastDate: DateTime(2100),
          );
          if (result != null) {
            dateSelected.value = result;
            item.value = DateTimeRangeDateFieldValue(dateTimeRange: dateSelected.value);
          }
        },
      ),
    );
  }
}
