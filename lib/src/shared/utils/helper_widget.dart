import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dynamic_filter/src/shared/constants/my_constants.dart';

import '../../models/app_filter.dart';
import '../widget/field_icon_text.dart';
import 'helper_reflect.dart';

final class HelperWidget {
  /// Small utility to measure a widget before actually putting it on screen.
  ///
  /// This can be helpful e.g. for positioning context menus based on the size they will take up.
  ///
  /// NOTE: Use sparingly, since this takes a complete layout and sizing pass for the subtree you
  /// want to measure.
  ///
  /// Compare https://api.flutter.dev/flutter/widgets/BuildOwner-class.html

  static Size measureWidget(Widget widget) {
    final PipelineOwner pipelineOwner = PipelineOwner();
    final _MeasurementView rootView = pipelineOwner.rootNode = _MeasurementView();
    final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
    final RenderObjectToWidgetElement<RenderBox> element = RenderObjectToWidgetAdapter<RenderBox>(
      container: rootView,
      debugShortDescription: '[root]',
      child: widget,
    ).attachToRenderTree(buildOwner);
    try {
      rootView.scheduleInitialLayout();
      pipelineOwner.flushLayout();
      return rootView.size;
    } finally {
      // Clean up.
      element.update(RenderObjectToWidgetAdapter<RenderBox>(container: rootView));
      buildOwner.finalizeTree();
    }
  }

  //hight light occurrentces
  static List<TextSpan> highlightOccurrences(String text, String query) {
    final List<TextSpan> spans = [];
    final String lowercaseText = text.toLowerCase();
    final String lowercaseQuery = query.toLowerCase();

    int lastIndex = 0;
    int index = lowercaseText.indexOf(lowercaseQuery);

    while (index != -1) {
      spans.add(TextSpan(text: text.substring(lastIndex, index)));
      spans.add(TextSpan(text: text.substring(index, index + query.length), style: const TextStyle(fontWeight: FontWeight.bold)));
      lastIndex = index + query.length;
      index = lowercaseText.indexOf(lowercaseQuery, lastIndex);
    }

    spans.add(TextSpan(text: text.substring(lastIndex, text.length)));

    return spans;
  }

  static Future<T?> showPopupMenu<T>({
    required BuildContext context,
    required List<PopupMenuEntry<T>> items,
    BoxConstraints? constraints,
  }) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return showMenu<T>(
      context: context,
      constraints: constraints,
      position: RelativeRect.fromRect(
        // renderBox.localToGlobal(Offset.zero) & renderBox.size,
        // Offset.zero & overlay.size,
        renderBox.localToGlobal(const Offset(0, 0)) & renderBox.size,
        Offset.zero & overlay.size,
      ),
      items: items,
    );
  }

  static List<Widget> buildSearchListFieldWidget({
    required BuildContext context,
    required List<Field> fields,
    void Function(Field field)? onSelected,
  }) {
    final search = ValueNotifier(fields.toList());
    final txtController = TextEditingController();
    const padding = 10.0;
    return [
      if (fields.length > 10)
        Container(
          height: 40,
          margin: const EdgeInsets.all(padding),
          child: TextField(
            controller: txtController,
            onChanged: (value) => HelperReflect.search(listOrigin: fields, listSearch: search, nameModel: 'queryName', keywordSearch: value),
            decoration: const InputDecoration(
              hintText: "Search...",
              prefixIcon: Icon(Icons.search_rounded),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      SizedBox(
        width: 200,
        height: 300,
        child: ValueListenableBuilder(
          valueListenable: search,
          builder: (context, searchValue, child) => ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: searchValue.length,
            itemBuilder: (context, index) {
              final item = searchValue[index];
              return InkWell(
                onTap: () {
                  onSelected?.call(item);
                  Navigator.of(context).pop();
                },
                child: Ink(
                  height: MyConstants.popupMenuItemHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FieldIconText(
                      field: item,
                      hightLightText: txtController.text,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ];
  }

  static PopupMenuEntry<T> popupMenuItemCheck<T>({
    required BuildContext context,
    T? value,
    T? selected,
    String label = '',
    VoidCallback? onTap,
  }) {
    return PopupMenuItem<T>(
      value: value,
      height: MyConstants.popupMenuItemHeight,
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          if (selected != null && selected == value) const Icon(Icons.check, color: Colors.green, size: MyConstants.iconSizeSmall),
        ],
      ),
    );
  }

  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
  }) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, //
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 4,
                    width: 40,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  Expanded(child: builder(context)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // theme
  static InputDecoration myInputDecoration() {
    return const InputDecoration(
      hintText: 'Value',
      hintStyle: TextStyle(fontSize: 12),
      contentPadding: EdgeInsets.all(5),
      border: OutlineInputBorder(borderRadius: MyConstants.borderRadius),
    );
  }

  static Future<T?> showSlidingBottomSheett<T>({
    required BuildContext context,
    required ScrollableWidgetBuilder builder,
  }) {
    final headerWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).hintColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          height: 4,
          width: 40,
          margin: const EdgeInsets.symmetric(vertical: 10),
        ),
      ],
    );

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true, //
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          snap: true,
          builder: (context, scrollController) {
            return ListView(
              controller: scrollController,
              // primary: false,
              shrinkWrap: true,
              children: [
                headerWidget,
                builder(context, scrollController),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MeasurementView extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    assert(child != null);
    child!.layout(const BoxConstraints(), parentUsesSize: true);
    size = child!.size;
  }

  @override
  void debugAssertDoesMeetConstraints() => true;
}
