import 'package:flutter/material.dart';
import 'package:team_queue_app/src/services/state/player/_classes/player.dart';
import 'package:team_queue_app/src/services/state/player/_classes/player.partial.dart';
import 'package:uuid/uuid.dart';
import 'package:team_queue_app/src/views/widgets/name_form.dart';
import 'package:team_queue_app/src/views/team_generator/player_setup/player_rating_form.dart';
import 'package:team_queue_app/src/views/widgets/remove_button.dart';
import 'package:team_queue_app/src/views/widgets/disabled_button.dart';

class PlayerEntry extends StatefulWidget {
  const PlayerEntry(
      {Key? key,
      Player? player,
      VoidCallback? removeRow,
      required void Function(PlayerPartial) saveUpdates})
      : _player = player,
        _saveUpdates = saveUpdates,
        _removeRow = removeRow,
        super(key: key);
  // private properties
  final Player? _player;
  final Uuid _uuid = const Uuid();

  // private methods
  final void Function(PlayerPartial partial) _saveUpdates;
  final VoidCallback? _removeRow;

  @override
  State<PlayerEntry> createState() => _PlayerEntryState();
}

class _PlayerEntryState extends State<PlayerEntry> {
  late Player? player;
  PlayerPartial? partial;

  void _saveName(String name) {
    final PlayerPartial? partial = this.partial;
    if (partial != null) {
      final int? partialRating = partial.rating;
      if (name != partial.name && name.isNotEmpty) {
        partial.name = name;
        // name is valid now. check if rating is also valid
        if (partialRating != null && partialRating > 0) {
          widget._saveUpdates(partial);
        }
      }
    }
  }

  void _saveRating(int rating) {
    final PlayerPartial? partial = this.partial;
    if (partial != null) {
      final String? partialName = partial.name;
      if (rating != partial.rating && rating > 0) {
        partial.rating = rating;
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
        PlayerPartial(id: widget._uuid.v4(), name: '', rating: 0);
    final VoidCallback? removeRow = widget._removeRow;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: removeRow != null
              ? RemoveButton(onTap: removeRow)
              : DisabledButton(
                  child: RemoveButton(
                    onTap: () {},
                  ),
                ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
            child: NameForm(
              saveName: _saveName,
              initialName: partial!.name,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: PlayerRatingForm(
              saveRating: _saveRating,
              initialRating: partial!.rating!,
            ),
          ),
        ),
      ],
    );
  }
}
