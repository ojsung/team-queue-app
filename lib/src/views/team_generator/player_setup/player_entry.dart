import 'package:flutter/material.dart';
import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.dart';
import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.partial.dart';
import 'package:team_queue_app/src/services/state/player_profile/player_profile_state_entry.dart';
import 'package:team_queue_app/src/views/team_generator/player_setup/player_name_form.dart';
import 'package:team_queue_app/src/views/team_generator/player_setup/player_rating_form.dart';

class PlayerEntry extends StatefulWidget {
  PlayerEntry(
      {Key? key,
      PlayerProfile? player,
      required void Function(PlayerProfilePartial) saveUpdates})
      : _player = player,
        _saveUpdates = saveUpdates,
        _playerName = player?.playerName ?? '',
        _playerRating = player?.playerRating ?? 0,
        super(key: key);
  // private properties
  final PlayerProfile? _player;
  final String _playerName;
  final int _playerRating;

  // private methods
  final void Function(PlayerProfilePartial partial) _saveUpdates;

  @override
  State<PlayerEntry> createState() => _PlayerEntryState();
}

class _PlayerEntryState extends State<PlayerEntry> {
  late PlayerProfilePartial partial;
  PlayerProfile? player;

  void _saveName(String name) {
    if (name != partial.playerName && name.isNotEmpty) {
      setState(() {
        partial.playerName = name;
        if (partial.playerRating != null && name.isNotEmpty) {
          widget._saveUpdates(partial);
        }
      });
    }
  }

  void _saveRating(int rating) {
    if (rating != partial.playerRating) {
      setState(() {
        partial.playerRating = rating;
        if (partial.playerName != null && partial.playerName!.isNotEmpty) {
          widget._saveUpdates(partial);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    player = widget._player;
    partial = player?.toPartial() ??
        PlayerProfilePartial(playerId: UniqueKey().toString());
    return Row(
      children: [
        Expanded(
          child: PlayerNameForm(
            saveName: _saveName,
            initialName: widget._playerName,
          ),
        ),
        Expanded(
          child: PlayerRatingForm(
            saveRating: _saveRating,
            initialRating: widget._playerRating,
          ),
        )
      ],
    );
  }
}
