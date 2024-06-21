import 'package:flutter/material.dart';

import '../../models/field.dart';
import '../constants/my_constants.dart';
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
        FlowySvg(field.type.svgData),
        const SizedBox(width: MyConstants.paddingField),
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
