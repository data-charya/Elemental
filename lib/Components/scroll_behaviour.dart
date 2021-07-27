import 'package:flutter/material.dart';

/// Removes the material glow behaviour which was default for
/// overscroll on Android
class ScrollWithoutMaterialOverflowGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
