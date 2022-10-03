import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.dart';
import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.partial.dart';
import 'package:team_queue_app/src/views/widgets/name_form.dart';
import 'package:team_queue_app/src/views/team_generator/player_setup/player_rating_form.dart';
import 'package:team_queue_app/src/views/widgets/remove_row_button.dart';
import 'package:team_queue_app/src/views/widgets/disabled_button.dart';

class PlayerEntry extends StatefulWidget {
  const PlayerEntry(
      {Key? key,
      PlayerProfile? player,
      VoidCallback? removeRow,
      required void Function(PlayerProfilePartial) saveUpdates})
      : _player = player,
        _saveUpdates = saveUpdates,
        _removeRow = removeRow,
        super(key: key);
  // private properties
  final PlayerProfile? _player;
  final Uuid _uuid = const Uuid();

  // private methods
  final void Function(PlayerProfilePartial partial) _saveUpdates;
  final VoidCallback? _removeRow;

  @override
  State<PlayerEntry> createState() => _PlayerEntryState();
}

class _PlayerEntryState extends State<PlayerEntry> {
  late PlayerProfile? player;
  PlayerProfilePartial? partial;

  void _saveName(String name) {
    final PlayerProfilePartial? partial = this.partial;
    if (partial != null) {
      final int? partialRating = partial.playerRating;
      if (name != partial.playerName && name.isNotEmpty) {
        partial.playerName = name;
        // name is valid now. check if rating is also valid
        if (partialRating != null && partialRating > 0) {
          widget._saveUpdates(partial);
        }
      }
    }
  }

  void _saveRating(int rating) {
    final PlayerProfilePartial? partial = this.partial;
    if (partial != null) {
      final String? partialName = partial.playerName;
      if (rating != partial.playerRating && rating > 0) {
        partial.playerRating = rating;
        if (partialName != null && partialName.isNotEmpty) {
          widget._saveUpdates(partial);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    player = widget._player;
    partial ??= player?.toPartial() ??
        PlayerProfilePartial(
            playerId: widget._uuid.v4(), playerName: '', playerRating: 0);
    final VoidCallback? removeRow = widget._removeRow;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        removeRow != null
            ? RemoveRowButton(removeRow: removeRow)
            : DisabledButton(
                child: RemoveRowButton(
                  removeRow: () {},
                ),
              ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: NameForm(
              saveName: _saveName,
              initialName: partial!.playerName,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: PlayerRatingForm(
              saveRating: _saveRating,
              initialRating: partial!.playerRating!,
            ),
          ),
        ),
      ],
    );
  }
}
