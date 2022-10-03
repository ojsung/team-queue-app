import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameForm extends StatefulWidget {
  const NameForm(
      {Key? key,
      required void Function(String) saveName,
      String? initialName = ''})
      : _initialName = initialName ?? '',
        _saveName = saveName,
        super(key: key);
  final String _initialName;
  final void Function(String) _saveName;

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  String? name;
  final textController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    name ??= widget._initialName;
    return SizedBox(
      height: 24,
      child: Focus(
        child: TextField(
          controller: textController,
          focusNode: focusNode,
          autocorrect: false,
        ),
        onFocusChange: (isFocused) {
          setState(() {
            widget._saveName(textController.text);
          });
        },
      ),
    );
  }
}
