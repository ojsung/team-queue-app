import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_queue_app/src/views/team_generator/team_setup/team_entry.dart';
import 'package:team_queue_app/src/views/widgets/add_row_button.dart';
import 'package:team_queue_app/src/views/widgets/name_form.dart';
import 'package:team_queue_app/src/views/widgets/sliding_card.dart';

class TeamSetup extends StatefulWidget {
  const TeamSetup(
      {Key? key, required VoidCallback goBack, required VoidCallback goNext})
      : _goBack = goBack,
        _goNext = goNext,
        super(key: key);
  final VoidCallback _goBack;
  final VoidCallback _goNext;
  @override
  State<TeamSetup> createState() => _TeamSetupState();
}

class _TeamSetupState extends State<TeamSetup> {
  final List<TeamEntry> _items = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void addRow() {
    _listKey.currentState
        ?.insertItem(_items.length, duration: Duration(milliseconds: 200));
    setState(() {
      _items.add(TeamEntry());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: widget._goBack,
                child: const Text('Back'),
              ),
              TextButton(
                onPressed: widget._goNext,
                child: Text('Next'),
              )
            ],
          ),
          AnimatedList(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            key: _listKey,
            initialItemCount: _items.length,
            itemBuilder: (context, index, animation) {
              return SlidingCard(animation: animation, child: _items[index]);
            },
          ),
          Center(
              child: AddRowButton(
            addRow: addRow,
          ))
        ]),
      ),
    );
  }
}
