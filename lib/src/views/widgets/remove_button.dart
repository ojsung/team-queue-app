import 'package:flutter/material.dart';

class RemoveButton extends StatelessWidget {
  const RemoveButton({Key? key, required VoidCallback onTap})
      : _onTap = onTap,
        super(key: key);
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onTap,
      icon: const Icon(Icons.remove_circle_outline, size: 18),
    );
  }
}
