part of '../advanced_filter_anchor.dart';

const _flex = [2, 3];

class AdvancedFilterEditorItem extends StatelessWidget {
  const AdvancedFilterEditorItem({super.key});

  @override
  Widget build(BuildContext context) {
    final item = context.watch<FieldAdvancedFilter>();

    Widget child;
    switch (item.field.type) {
      // past key to force rebuild widget
      case FieldType.Date:
        child = _BuildDateInput(key: UniqueKey());
        break;
      case FieldType.Number:
        child = _BuildNumberFieldInput(key: UniqueKey());
        break;
      default:
        child = _BuildTextFieldInput(key: UniqueKey());
    }

    return Container(
      height: MyConstants.popupMenuItemHeight,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: child,
    );
  }
}

class _BuildDateInput extends StatelessWidget {
  const _BuildDateInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: _flex[0],
          child: const Row(
            children: [
              SizedBox(width: 60, child: FilterMustmatchButton()),
              SizedBox(width: MyConstants.paddingField),
              Expanded(
                  child: Row(
                children: [
                  Expanded(child: FieldNameFilterButton()),
                  //todo: future here StartDate - EndDate picker
                ],
              )),
            ],
          ),
        ),
        const SizedBox(width: MyConstants.paddingField),
        Expanded(
          flex: _flex[1],
          child: const Row(
            children: [
              Expanded(
                flex: 1,
                child: FieldOperatorButton(),
              ),
              SizedBox(width: MyConstants.paddingField),
              Expanded(
                flex: 2,
                child: DateOperatorTypeFilterEditorItemButton(),
              ),
              SizedBox(width: MyConstants.paddingField),
              OptionAdvancedFilterButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class _BuildTextFieldInput extends StatelessWidget {
  const _BuildTextFieldInput({super.key});

  @override
  Widget build(BuildContext context) {
    return _BuildFieldInput(builder: (context) {
      final item = context.read<FieldAdvancedFilter>();
      if (item.operatorType == TextOperator.isEmpty || item.operatorType == TextOperator.isNotEmpty) {
        item.value = null;
        return const SizedBox();
      }
      return TextFormField(
        initialValue: (item.value is String?) ? item.value?.toString() : null,
        cursorHeight: 15,
        decoration: HelperWidget.myInputDecoration(),
        onChanged: (value) => item.value = value,
      );
    });
  }
}

class _BuildNumberFieldInput extends StatelessWidget {
  const _BuildNumberFieldInput({super.key});

  @override
  Widget build(BuildContext context) {
    return _BuildFieldInput(builder: (context) {
      final item = context.read<FieldAdvancedFilter>();
      if (item.operatorType == NumberOperator.isEmpty || item.operatorType == NumberOperator.isNotEmpty) {
        item.value = null;
        return const SizedBox();
      }
      return TextFormField(
        initialValue: (item.value is num?) ? item.value?.toString() : null,
        cursorHeight: 15,
        keyboardType: TextInputType.number,
        decoration: HelperWidget.myInputDecoration(),
        onChanged: (value) => item.value = num.tryParse(value),
      );
    });
  }
}

class _BuildFieldInput extends StatelessWidget {
  const _BuildFieldInput({required this.builder});
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: _flex[0],
          child: const Row(
            children: [
              SizedBox(width: 60, child: FilterMustmatchButton()),
              SizedBox(width: MyConstants.paddingField),
              Expanded(child: FieldNameFilterButton()),
            ],
          ),
        ),
        const SizedBox(width: MyConstants.paddingField),
        Expanded(
          flex: _flex[1],
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: FieldOperatorButton(),
              ),
              const SizedBox(width: MyConstants.paddingField),
              Expanded(
                flex: 2,
                child: builder(context),
              ),
              const SizedBox(width: MyConstants.paddingField),
              const OptionAdvancedFilterButton(),
            ],
          ),
        ),
      ],
    );
  }
}
