import 'package:flutter/material.dart';

class SlidingCard extends StatelessWidget {
  const SlidingCard({
    Key? key,
    required Animation<double> animation,
    required Widget child,
  })  : _animation = animation,
        _child = child,
        super(key: key);
  final Animation<double> _animation;
  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: const Offset(0, 0),
      ).animate(_animation),
      child: _child
    );
  }
}
