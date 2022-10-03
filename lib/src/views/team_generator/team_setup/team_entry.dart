import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:team_queue_app/src/views/widgets/name_form.dart';
import 'package:team_queue_app/src/views/widgets/remove_row_button.dart';

class TeamEntry extends StatefulWidget {
  const TeamEntry(
      {Key? key,})
      : super(key: key);
  
  @override
  State<TeamEntry> createState() => _TeamEntryState();
}

class _TeamEntryState extends State<TeamEntry> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RemoveRowButton(removeRow: () {}),
        Expanded(flex: 1, child: NameForm(saveName: (String name) {})),
        SizedBox(
          height: 24,
          width: 24,
        ),
      ],
    );
  }
}
