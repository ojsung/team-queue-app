import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddPlayerButton extends StatelessWidget {
  const AddPlayerButton({Key? key, required void Function() addRow})
      : _addPlayer = addRow,
        super(key: key);
  final void Function() _addPlayer;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 36,
      child: IconButton(
        onPressed: _addPlayer,
        icon: const Icon(Icons.add_circle, size: 36),
      ),
    );
  }
}
