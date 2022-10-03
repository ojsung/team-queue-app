import 'package:flutter/material.dart';

class DisabledButton extends StatelessWidget {
  const DisabledButton({Key? key, required Widget child})
      : _child = child,
        super(key: key);
  final Widget _child;
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      // ignore: prefer_const_constructors
      colorFilter: ColorFilter.mode(
        Colors.grey,
        BlendMode.saturation,
      ),
      child: _child,
    );
  }
}
