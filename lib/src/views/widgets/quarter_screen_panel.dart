import 'package:flutter/material.dart';

class QuarterScreenPanel extends StatelessWidget {
  const QuarterScreenPanel(
      {Key? key, required Widget child, double? width, double? height})
      : _child = child,
      _width = width,
      _height = height,
        super(key: key);
  final Widget _child;
  final double? _width;
  final double? _height;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.all(8),
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: _child,
    );
  }
}
