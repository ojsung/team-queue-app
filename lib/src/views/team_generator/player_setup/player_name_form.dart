import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlayerNameForm extends StatefulWidget {
  const PlayerNameForm(
      {Key? key,
      required void Function(String) saveName,
      String? initialName = ''})
      : _initialName = initialName ?? '',
        super(key: key);
  final String _initialName;

  @override
  State<PlayerNameForm> createState() => _PlayerNameFormState();
}

class _PlayerNameFormState extends State<PlayerNameForm> {
  bool isEditing = true;
  late String name;
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
    name = widget._initialName;
    return SizedBox(
      height: 24,
      width: 120,
      child: Focus(
        child: isEditing
            ? TextField(
                controller: textController,
                focusNode: focusNode,
              )
            : InkWell(
                child: Text(
                  textController.text.isEmpty
                      ? 'Tap to edit'
                      : textController.text,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  setState(() => isEditing = true);
                  focusNode.requestFocus();
                },
              ),
        onFocusChange: (isFocused) {
          setState(() => isEditing = isFocused);
        },
      ),
    );
  }
}
