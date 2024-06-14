import 'package:flutter/material.dart';

class MyPopupMenuItem<T> extends PopupMenuEntry<T> {
  const MyPopupMenuItem({
    super.key,
    this.height = kMinInteractiveDimension,
    required this.child,
  });

  @override
  final double height;

  final Widget child;

  @override
  bool represents(T? value) => false;

  @override
  MyPopupMenuItemState<T, MyPopupMenuItem<T>> createState() => MyPopupMenuItemState<T, MyPopupMenuItem<T>>();
}

class MyPopupMenuItemState<T, W extends MyPopupMenuItem<T>> extends State<W> {
  @override
  Widget build(BuildContext context) => widget.child;
}
