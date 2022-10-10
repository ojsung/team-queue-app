import 'package:flutter/material.dart';

class OpacityToggle extends StatelessWidget {
  const OpacityToggle(
      {Key? key, bool? isEnabled, VoidCallback? onTap, required Widget child})
      : _isEnabled = isEnabled ?? false,
        _child = child,
        super(key: key);

  final bool _isEnabled;
  final Widget _child;
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        _isEnabled
            ? Colors.white.withOpacity(0.4)
            : Colors.white.withOpacity(0),
        BlendMode.saturation,
      ),
      child: _child,
    );
  }
}
