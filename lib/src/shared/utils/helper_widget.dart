import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dynamic_filter/src/shared/constants/my_constants.dart';

import '../../models/app_filter.dart';
import '../widget/flowy_svg.dart';
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
  }) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    return showMenu<T>(
      context: context,
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
                    child: Row(
                      children: [
                        FlowySvg(item.fieldType.svgData),
                        const SizedBox(width: 5),
                        Expanded(
                          child: txtController.text.isEmpty
                              ? Text(
                                  item.queryName,
                                )
                              : RichText(
                                  text: TextSpan(
                                    children: HelperWidget.highlightOccurrences(item.queryName, txtController.text),
                                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                                  ),
                                ),
                        ),
                      ],
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
