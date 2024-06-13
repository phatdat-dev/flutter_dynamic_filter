//clone popup menu

import 'package:flutter/material.dart';

/// An item in a Material Design popup menu.
///
/// To show a popup menu, use the [showMenu] function. To create a button that
/// shows a popup menu, consider using [PopupMenuButton].
///
/// To show a checkmark next to a popup menu item, consider using
/// [CheckedPopupMenuItem].
///
/// Typically the [child] of a [CustomPopupMenuItem] is a [Text] widget. More
/// elaborate menus with icons can use a [ListTile]. By default, a
/// [CustomPopupMenuItem] is [kMinInteractiveDimension] pixels high. If you use a widget
/// with a different height, it must be specified in the [height] property.
///
/// {@tool snippet}
///
/// Here, a [Text] widget is used with a popup menu item. The `Menu` type
/// is an enum, not shown here.
///
/// ```dart
/// const PopupMenuItem<Menu>(
///   value: Menu.itemOne,
///   child: Text('Item 1'),
/// )
/// ```
/// {@end-tool}
///
/// See the example at [PopupMenuButton] for how this example could be used in a
/// complete menu, and see the example at [CheckedPopupMenuItem] for one way to
/// keep the text of [CustomPopupMenuItem]s that use [Text] widgets in their [child]
/// slot aligned with the text of [CheckedPopupMenuItem]s or of [CustomPopupMenuItem]
/// that use a [ListTile] in their [child] slot.
///
/// See also:
///
///  * [PopupMenuDivider], which can be used to divide items from each other.
///  * [CheckedPopupMenuItem], a variant of [CustomPopupMenuItem] with a checkmark.
///  * [showMenu], a method to dynamically show a popup menu at a given location.
///  * [PopupMenuButton], an [IconButton] that automatically shows a menu when
///    it is tapped.
class CustomPopupMenuItem<T> extends PopupMenuEntry<T> {
  /// Creates an item for a popup menu.
  ///
  /// By default, the item is [enabled].
  ///
  /// The `enabled` and `height` arguments must not be null.
  const CustomPopupMenuItem({
    super.key,
    this.value,
    this.onTap,
    this.enabled = true,
    this.textStyle,
    this.labelTextStyle,
    this.mouseCursor,
    required this.child,
  });

  /// The value that will be returned by [showMenu] if this entry is selected.
  final T? value;

  /// Called when the menu item is tapped.
  final VoidCallback? onTap;

  /// Whether the user is permitted to select this item.
  ///
  /// Defaults to true. If this is false, then the item will not react to
  /// touches.
  final bool enabled;

  /// The minimum height of the menu item.
  ///
  /// Defaults to [kMinInteractiveDimension] pixels.
  @override
  final double height = 0;

  /// The text style of the popup menu item.
  ///
  /// If this property is null, then [PopupMenuThemeData.textStyle] is used.
  /// If [PopupMenuThemeData.textStyle] is also null, then [TextTheme.titleMedium]
  /// of [ThemeData.textTheme] is used.
  final TextStyle? textStyle;

  /// The label style of the popup menu item.
  ///
  /// When [ThemeData.useMaterial3] is true, this styles the text of the popup menu item.
  ///
  /// If this property is null, then [PopupMenuThemeData.labelTextStyle] is used.
  /// If [PopupMenuThemeData.labelTextStyle] is also null, then [TextTheme.labelLarge]
  /// is used with the [ColorScheme.onSurface] color when popup menu item is enabled and
  /// the [ColorScheme.onSurface] color with 0.38 opacity when the popup menu item is disabled.
  final MaterialStateProperty<TextStyle?>? labelTextStyle;

  /// {@template flutter.material.popupmenu.mouseCursor}
  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  /// {@endtemplate}
  ///
  /// If null, then the value of [PopupMenuThemeData.mouseCursor] is used. If
  /// that is also null, then [MaterialStateMouseCursor.clickable] is used.
  final MouseCursor? mouseCursor;

  /// The widget below this widget in the tree.
  ///
  /// Typically a single-line [ListTile] (for menus with icons) or a [Text]. An
  /// appropriate [DefaultTextStyle] is put in scope for the child. In either
  /// case, the text should be short enough that it won't wrap.
  final Widget child;

  @override
  bool represents(T? value) => value == this.value;

  @override
  CustomPopupMenuItemState<T, CustomPopupMenuItem<T>> createState() => CustomPopupMenuItemState<T, CustomPopupMenuItem<T>>();
}

/// The [State] for [CustomPopupMenuItem] subclasses.
///
/// By default this implements the basic styling and layout of Material Design
/// popup menu items.
///
/// The [buildChild] method can be overridden to adjust exactly what gets placed
/// in the menu. By default it returns [CustomPopupMenuItem.child].
///
/// The [handleTap] method can be overridden to adjust exactly what happens when
/// the item is tapped. By default, it uses [Navigator.pop] to return the
/// [CustomPopupMenuItem.value] from the menu route.
///
/// This class takes two type arguments. The second, `W`, is the exact type of
/// the [Widget] that is using this [State]. It must be a subclass of
/// [CustomPopupMenuItem]. The first, `T`, must match the type argument of that widget
/// class, and is the type of values returned from this menu.
class CustomPopupMenuItemState<T, W extends CustomPopupMenuItem<T>> extends State<W> {
  /// The menu item contents.
  ///
  /// Used by the [build] method.
  ///
  /// By default, this returns [CustomPopupMenuItem.child]. Override this to put
  /// something else in the menu entry.
  @protected
  Widget buildChild() => widget.child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final PopupMenuThemeData defaults = theme.useMaterial3 ? _PopupMenuDefaultsM3(context) : _PopupMenuDefaultsM2(context);
    final Set<MaterialState> states = <MaterialState>{
      if (!widget.enabled) MaterialState.disabled,
    };

    TextStyle style = theme.useMaterial3
        ? (widget.labelTextStyle?.resolve(states) ?? popupMenuTheme.labelTextStyle?.resolve(states)! ?? defaults.labelTextStyle!.resolve(states)!)
        : (widget.textStyle ?? popupMenuTheme.textStyle ?? defaults.textStyle!);

    if (!widget.enabled && !theme.useMaterial3) {
      style = style.copyWith(color: theme.disabledColor);
    }

    Widget item = AnimatedDefaultTextStyle(
      style: style,
      duration: kThemeChangeDuration,
      child: buildChild(),
    );

    if (!widget.enabled) {
      final bool isDark = theme.brightness == Brightness.dark;
      item = IconTheme.merge(
        data: IconThemeData(opacity: isDark ? 0.5 : 0.38),
        child: item,
      );
    }

    return MergeSemantics(
      child: Semantics(
        enabled: widget.enabled,
        button: true,
        child: GestureDetector(
          onTap: widget.onTap,
          child: item,
        ),
      ),
    );
  }
}

class _PopupMenuDefaultsM2 extends PopupMenuThemeData {
  _PopupMenuDefaultsM2(this.context) : super(elevation: 8.0);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);
  late final TextTheme _textTheme = _theme.textTheme;

  @override
  TextStyle? get textStyle => _textTheme.titleMedium;
}

// BEGIN GENERATED TOKEN PROPERTIES - PopupMenu

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

// Token database version: v0_143

class _PopupMenuDefaultsM3 extends PopupMenuThemeData {
  _PopupMenuDefaultsM3(this.context) : super(elevation: 3.0);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colors = _theme.colorScheme;
  late final TextTheme _textTheme = _theme.textTheme;

  @override
  MaterialStateProperty<TextStyle?>? get labelTextStyle {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      final TextStyle style = _textTheme.labelLarge!;
      if (states.contains(MaterialState.disabled)) {
        return style.apply(color: _colors.onSurface.withOpacity(0.38));
      }
      return style.apply(color: _colors.onSurface);
    });
  }

  @override
  Color? get color => _colors.surface;

  @override
  Color? get shadowColor => _colors.shadow;

  @override
  Color? get surfaceTintColor => _colors.surfaceTint;

  @override
  ShapeBorder? get shape => const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0)));
}
// END GENERATED TOKEN PROPERTIES - PopupMenu
