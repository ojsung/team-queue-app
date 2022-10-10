import 'package:flutter/material.dart';
import 'package:team_queue_app/src/services/state/player/_classes/player.dart';
import 'package:team_queue_app/src/services/state/player/_classes/player.partial.dart';
import 'package:team_queue_app/src/services/state/player/player_state.dart';
import 'package:team_queue_app/src/views/widgets/add_row_button.dart';
import 'package:team_queue_app/src/views/team_generator/player_setup/player_entry.dart';
import 'package:team_queue_app/src/views/widgets/dropdown_selection_item.dart';
import 'package:team_queue_app/src/views/widgets/dropdown_selection_list.dart';
import 'package:team_queue_app/src/views/widgets/sliding_card.dart';

class PlayerSetup extends StatefulWidget {
  const PlayerSetup(
      {Key? key, required PlayerState state, required VoidCallback goNext})
      : _state = state,
        _goNext = goNext,
        super(key: key);
  final PlayerState _state;
  final VoidCallback _goNext;

  @override
  State<PlayerSetup> createState() => _PlayerSetupState();
}

class _PlayerSetupState extends State<PlayerSetup> {
  // public properties
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // private properties
  final List<Player?> _items = [];
  final ScrollController _listScrollController = ScrollController();

  final Duration _duration = const Duration(milliseconds: 200);
  // private methods
  void saveUpdates(PlayerPartial? partial) {
    Player? player = partial?.toPlayer();
    if (player != null) {
      widget._state.upsert(values: [player]);
    }
  }

  void addRow({Player? player}) {
    _listKey.currentState?.insertItem(_items.length, duration: _duration);
    setState(() {
      _items.add(player);
    });
    _listScrollController.animateTo(
    _listScrollController.position.maxScrollExtent,
    duration: const Duration(milliseconds: 1000),
    curve: Curves.fastOutSlowIn,
  );
  }

  removeRow(int index, Player? player) {
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

  void deletePlayer({required Player player}) {
    final playerIndex =
        _items.indexWhere((listedPlayer) => listedPlayer?.id == player.id);
    if (playerIndex > -1) {
      removeRow(playerIndex, player);
    }
    widget._state.delete(keys: [
      player.id,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final Iterable<Player> allPlayers = widget._state.currentState.values;
    // to define the max height of the list, we need to also define every y-dimension
    const double innerPaddingHeight = 12.0;
    const double buttonHeight = 28.0;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      debugPrint(constraints.maxHeight.toString());
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: innerPaddingHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Players',
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.0,
                  ),
                ),
                DropdownSelectionList<Player>(
                  items: [
                    ...allPlayers.map((player) {
                      final bool isEnabled = _items.contains(player);
                      return DropdownSelectionItem<Player>(
                        value: player,
                        onDelete: () => deletePlayer(player: player),
                        onTap: () => isEnabled ? addRow(player: player) : () {},
                        isEnabled: isEnabled,
                      ).build(context);
                    })
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  heightFactor: 1.0,
                  child: TextButton(
                    onPressed: widget._goNext,
                    style: TextButton.styleFrom(
                        fixedSize: const Size(64, buttonHeight),
                        padding: const EdgeInsets.all(4),
                        minimumSize: const Size(64, buttonHeight),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        height: 1.0,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight -
                      buttonHeight -
                      innerPaddingHeight * 2 -
                      // size of the addrowbutton (icon 36 + padding-bottom 8 + padding-top 8)
                      52),
              child: AnimatedList(
                shrinkWrap: true,
                key: _listKey,
                clipBehavior: Clip.antiAlias,
                initialItemCount: _items.length,
                controller: _listScrollController,
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
            ),
            Center(
              child: AddRowButton(
                addRow: addRow,
              ),
            )
          ],
        ),
      );
    });
  }
}
