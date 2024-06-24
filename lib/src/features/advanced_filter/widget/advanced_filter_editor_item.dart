part of '../advanced_filter_button.dart';

const _flex = [2, 3];

class AdvancedFilterEditorItem extends StatelessWidget {
  const AdvancedFilterEditorItem({super.key});

  @override
  Widget build(BuildContext context) {
    final item = context.watch<FieldAdvancedFilter>();

    Widget child;
    switch (item.field.type) {
      // truyền Key vô cho nó force rebuild, mắc công dính const nó ko rebuild
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
                  // future here StartDate - EndDate picker
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
    final item = context.read<FieldAdvancedFilter>();
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
                child: TextFormField(
                  initialValue: item.value,
                  cursorHeight: 15,
                  decoration: const InputDecoration(
                    hintText: 'Value',
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                      borderRadius: MyConstants.borderRadius,
                    ),
                  ),
                  onChanged: (value) => item.value = value,
                ),
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

class _BuildNumberFieldInput extends StatelessWidget {
  const _BuildNumberFieldInput({super.key});

  @override
  Widget build(BuildContext context) {
    final item = context.read<FieldAdvancedFilter>();
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
                child: TextFormField(
                  initialValue: item.value?.toString(),
                  cursorHeight: 15,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Value',
                    hintStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                      borderRadius: MyConstants.borderRadius,
                    ),
                  ),
                  onChanged: (value) => item.value = num.tryParse(value),
                ),
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
