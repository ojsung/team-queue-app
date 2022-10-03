import 'package:flutter/material.dart';
import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.dart';
import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.partial.dart';
import 'package:team_queue_app/src/services/state/player_profile/player_profile_state.dart';
import 'package:team_queue_app/src/views/widgets/add_row_button.dart';
import 'package:team_queue_app/src/views/team_generator/player_setup/player_entry.dart';
import 'package:team_queue_app/src/views/widgets/sliding_card.dart';

class PlayerSetup extends StatefulWidget {
  const PlayerSetup(
      {Key? key,
      required PlayerProfileState state,
      required VoidCallback goNext})
      : _state = state,
        _goNext = goNext,
        super(key: key);
  final PlayerProfileState _state;
  final VoidCallback _goNext;

  @override
  State<PlayerSetup> createState() => _PlayerSetupState();
}

class _PlayerSetupState extends State<PlayerSetup> {
  // public properties
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // private properties
  final List<PlayerProfile?> _items = [];

  final Duration _duration = const Duration(milliseconds: 200);
  // private methods
  saveUpdates(PlayerProfilePartial partial) {
    PlayerProfile? player = partial.toPlayerProfile();
    if (player != null) {
      widget._state.upsert(values: [player]);
    }
  }

  void addRow({PlayerProfile? player}) {
    _listKey.currentState?.insertItem(_items.length, duration: _duration);
    setState(() {
      _items.add(player);
    });
  }

  removeRow(int index, PlayerProfile? player) {
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SlidingCard(
        animation: animation,
        child: PlayerEntry(
          saveUpdates: saveUpdates,
          player: player,
        ),
      ),
    );
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Players',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.playlist_add),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: widget._goNext,
                    child: const Text('Next'),
                  ),
                ),
              ),
            ],
          ),
          AnimatedList(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            key: _listKey,
            initialItemCount: _items.length,
            itemBuilder: (context, index, animation) {
              return SlidingCard(
                  animation: animation,
                  child: PlayerEntry(
                    removeRow: () {
                      removeRow(index, _items[index]);
                    },
                    saveUpdates: saveUpdates,
                    player: _items[index],
                  ));
            },
          ),
          Center(
            child: AddRowButton(
              addRow: addRow,
            ),
          )
        ],
      ),
    );
  }
}
