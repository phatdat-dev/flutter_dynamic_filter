import 'package:flutter/material.dart';

import '../constants/my_constants.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton({
    super.key,
    this.leading,
    this.onPressed,
    required this.label,
  });
  final Widget? leading;
  final VoidCallback? onPressed;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed ?? () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        shape: const RoundedRectangleBorder(
          borderRadius: MyConstants.borderRadius,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: MyConstants.paddingField),
          ],
          Expanded(child: label),
          Icon(Icons.expand_more, size: Theme.of(context).textTheme.bodyMedium?.fontSize),
        ],
      ),
    );
  }
}
