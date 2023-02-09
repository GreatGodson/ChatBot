// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

// constant values
const double padding = 15.0;
const double hPadding = 20.0;
const double vPadding = 20.0;

class Dimensions {
  static void init({required BuildContext context}) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    sliderHeight = screenHeight / 6;
  }

  //declare variables here
  static late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double safeAreaHorizontal;
  static late double safeAreaVertical;
  static late double sliderHeight;
  static late double addToCartButtonHeight;
}

extension DimsExtension on BuildContext {
  Size get mediaQuerySize => MediaQuery.of(this).size;
  double deviceWidth([double extent = 1]) => mediaQuerySize.width * extent;
  double deviceHeight([double extent = 1]) => mediaQuerySize.height * extent;
  Orientation get deviceOrientation => MediaQuery.of(this).orientation;
  bool get isLandscape => deviceOrientation == Orientation.landscape;
  bool get isPortrait => deviceOrientation == Orientation.portrait;
}

class XBox extends StatelessWidget {
  const XBox(this._width);

  final double _width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
    );
  }
}

class YBox extends StatelessWidget {
  const YBox(this._height);

  final double _height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
    );
  }
}
