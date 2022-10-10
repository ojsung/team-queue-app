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
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            isDense: true,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
          maxLines: 1,
          style: const TextStyle(
            fontSize: 14,
          ),
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
