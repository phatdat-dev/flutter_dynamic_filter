import 'package:flutter/material.dart';
import 'package:flutter_dynamic_filter/src/models/enum/field_type.dart';

import '../../models/field.dart';
import '../utils/helper_widget.dart';
import 'flowy_svg.dart';

class FieldIconText extends StatelessWidget {
  const FieldIconText({
    super.key,
    required this.field,
    this.hightLightText = "",
  });
  final Field field;
  final String hightLightText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FlowySvg(field.fieldType.svgData),
        const SizedBox(width: 5),
        Expanded(
          child: hightLightText.isEmpty
              ? Text(
                  field.queryName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )
              : RichText(
                  text: TextSpan(
                    children: HelperWidget.highlightOccurrences(field.queryName, hightLightText),
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
        ),
      ],
    );
  }
}
