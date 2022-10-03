import 'package:flutter/material.dart';

class AddRowButton extends StatelessWidget {
  const AddRowButton({Key? key, required VoidCallback addRow})
      : _addRow = addRow,
        super(key: key);
  final VoidCallback _addRow;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 36,
      child: IconButton(
        onPressed: _addRow,
        icon: const Icon(Icons.add_circle, size: 36),
      ),
    );
  }
}
