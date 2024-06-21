import 'package:flutter/material.dart';

import '../constants/my_constants.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  final Icon icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 26,
      child: InkWell(
        onTap: onPressed,
        borderRadius: MyConstants.borderRadius,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Row(
            children: [
              icon,
              const SizedBox(width: MyConstants.paddingField),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
