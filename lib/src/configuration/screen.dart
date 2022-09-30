import 'package:flutter/widgets.dart';

class ScreenSize {
  ScreenSize(BuildContext context) {
    _screenSize = this;
    final EdgeInsets padding = MediaQuery.of(context).viewPadding;
    height = MediaQuery.of(context).size.height - padding.top - padding.bottom;
    width = MediaQuery.of(context).size.width;
  }

  factory ScreenSize.build(context) {
    _screenSize ??= ScreenSize(context);
    return _screenSize!;
  }
  static ScreenSize? _screenSize;
  late double height;
  late double width;
}
