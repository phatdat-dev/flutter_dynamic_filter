import 'package:flutter/material.dart';

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
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(vertical: 3, horizontal: 10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 5),
          ],
          Expanded(child: label),
          Icon(Icons.expand_more, size: Theme.of(context).textTheme.bodyMedium?.fontSize),
        ],
      ),
    );
  }
}
