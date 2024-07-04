// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// extension ScreenTypeExtension on ScreenType {
//   static ScreenType from(BoxConstraints constraints) {
//     double shortestSide = math.min(constraints.maxWidth.abs(), constraints.maxHeight.abs());

//     const settings = ResponsiveScreenSettings();

//     // final deviceWidth = GetPlatform.isDesktop ? constraints.maxWidth : shortestSide;
//     final deviceWidth = shortestSide;
//     if (deviceWidth >= settings.desktopChangePoint) return ScreenType.Desktop;
//     if (deviceWidth >= settings.tabletChangePoint) return ScreenType.Tablet;
//     if (deviceWidth < settings.watchChangePoint) return ScreenType.Watch;
//     return ScreenType.Phone;
//   }
// }

mixin ResponsiveMixin on Diagnosticable {
// mixin ResponsiveMixin {
  static late bool isMobile;
  static late bool isTablet;
  static late bool isDesktop;

  @protected
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        const settings = ResponsiveScreenSettings();
        final width = MediaQuery.sizeOf(context).width;
        final isPortrait = (orientation == Orientation.portrait);

        /// Nếu đang ở trạng thái bình thường (nằm dọc-mobile)
        isMobile = isPortrait && (width < settings.mobileChangePoint);
        isTablet = isPortrait && (width >= settings.mobileChangePoint) && (width < settings.desktopChangePoint);
        isDesktop = (width >= settings.desktopChangePoint);

        Widget? widget;

        if (isDesktop) {
          widget = buildDesktop(context);
        } else if (isTablet) {
          widget = buildTablet(context);
        } else if (isMobile) {
          widget = buildMobile(context);
        }
        widget ??= const Center(
            child: Text(
          'Sorry, this screen is not supported yet.',
          style: TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ));

        return wrapWidget(context, widget) ?? widget;
      },
    );
  }

  /// Wrap widget before build ex:
  /// ```dart
  /// @override
  /// Widget? wrapWidget(context, child) {
  ///   return GestureDetector(
  ///       //unforcus keyboard
  ///       onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
  ///       child: Scaffold(
  ///         body: child,
  ///       ));
  /// }
  /// ```
  Widget? wrapWidget(BuildContext context, Widget child) => null;

  Widget? buildDesktop(BuildContext context) => null;

  Widget? buildTablet(BuildContext context) => null;

  Widget? buildMobile(BuildContext context) => null;
}

class ResponsiveScreenSettings {
  /// When the width is greater als this value
  /// the display will be set as [ScreenType.Desktop]
  final double desktopChangePoint;

  /// When the width is greater als this value
  /// the display will be set as [ScreenType.Tablet]
  /// or when width greater als [watchChangePoint] and smaller als this value
  /// the display will be [ScreenType.Phone]
  final double mobileChangePoint;

  const ResponsiveScreenSettings({
    this.desktopChangePoint = 900,
    this.mobileChangePoint = 600,
  });
}
