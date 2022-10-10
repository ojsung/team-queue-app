import 'package:flutter/material.dart';
import 'package:team_queue_app/src/views/widgets/disabled_button.dart';

class PlayerRatingForm extends StatefulWidget {
  const PlayerRatingForm(
      {Key? key,
      required int initialRating,
      required void Function(int) saveRating})
      : _initialRating = initialRating,
        _saveRating = saveRating,
        super(key: key);
  final Function(int) _saveRating;
  final int _initialRating;

  @override
  State<PlayerRatingForm> createState() => _PlayerRatingFormState();
}

class _PlayerRatingFormState extends State<PlayerRatingForm> {
  int? currentRating;
  void _updateRating(int rating) {
    setState(() {
      currentRating = rating;
      widget._saveRating(rating);
    });
  }

  @override
  Widget build(BuildContext context) {
    currentRating ??= widget._initialRating;
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          for (var i = 1; i <= 10; i++)
            Expanded(
              child: RatingBar(
                index: i,
                updateRating: () {
                  debugPrint('called with $i');
                  _updateRating(i);
                },
                currentRating: currentRating,
              ),
            )
        ],
      ),
    );
  }
}

class RatingBar extends StatefulWidget {
  const RatingBar({
    Key? key,
    required int index,
    required VoidCallback updateRating,
    required currentRating,
  })  : _index = index,
        _updateRating = updateRating,
        _currentRating = currentRating,
        super(key: key);
  final int _index;
  final VoidCallback _updateRating;
  final int _currentRating;

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  late int currentRating;
  late ColorScheme colorScheme;
  @override
  Widget build(BuildContext context) {
    currentRating = widget._currentRating;
    colorScheme = Theme.of(context).colorScheme;
    Widget inkwell = InkWell(
      onTap: () => widget._updateRating(),
      child: SizedBox(
        height: 24,
        width: 24,
        child: Container(
          color: colorScheme.primary,
          child: Center(
            child: Text(
              widget._index.toString(),
              style: TextStyle(color: colorScheme.onPrimary, fontSize: 12),
            ),
          ),
        ),
      ),
    );
    return currentRating >= widget._index
        ? inkwell
        : DisabledButton(child: inkwell);
  }
}
