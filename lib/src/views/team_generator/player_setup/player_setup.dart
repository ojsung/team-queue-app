import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.dart';
import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.partial.dart';
import 'package:team_queue_app/src/services/state/player_profile/player_profile_state.dart';
import 'package:team_queue_app/src/services/state/player_profile/player_profile_state_entry.dart';
import 'package:team_queue_app/src/views/team_generator/player_setup/add_player_button.dart';
import 'package:team_queue_app/src/views/team_generator/player_setup/player_entry.dart';

class PlayerSetup extends StatefulWidget {
  PlayerSetup({Key? key, required PlayerProfileState state})
      : _state = state,
        super(key: key);
  final PlayerProfileState _state;

  @override
  State<PlayerSetup> createState() => _PlayerSetupState();
}

class _PlayerSetupState extends State<PlayerSetup> {
  // public properties
  int _rowsToDisplay = 1;
  // private methods
  saveUpdates(PlayerProfilePartial partial) {
    PlayerProfile? player = partial.toPlayerProfile();
    if (player != null) {
      widget._state.upsert(values: [player]);
    }
  }

  final List<PlayerProfileStateEntry?> _playerList = [];

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(animation),
          child: PlayerEntry(
            saveUpdates: saveUpdates,
          ),
        );
      },
    );
  }
}
