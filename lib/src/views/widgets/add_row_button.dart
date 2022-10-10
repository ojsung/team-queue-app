import 'package:flutter/material.dart';

class AddRowButton extends StatelessWidget {
  const AddRowButton({Key? key, required VoidCallback addRow})
      : _addRow = addRow,
        super(key: key);
  final VoidCallback _addRow;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _addRow,
      icon: const Icon(Icons.add_circle),
      iconSize: 36,
    );
  }
}
