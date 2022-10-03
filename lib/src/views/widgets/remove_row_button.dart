import 'package:flutter/material.dart';

class RemoveRowButton extends StatelessWidget {
  const RemoveRowButton({Key? key, required VoidCallback removeRow})
      : _removeRow = removeRow,
        super(key: key);
  final VoidCallback _removeRow;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _removeRow,
      icon: const Icon(Icons.remove_circle_outline, size: 24),
    );
  }
}
