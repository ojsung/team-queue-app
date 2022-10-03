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
  static const List<int> _red = [255, 87, 51, 1];
  static const List<int> _green = [51, 255, 87, 1];
  final int _index;
  final VoidCallback _updateRating;
  final int _currentRating;

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  late int currentRating;
  late Color backgroundColor;

  Color _calculateBackgroundColor() {
    final int index = widget._index;
    final int steps = index - 1;
    const List<int> green = RatingBar._green;
    const List<int> red = RatingBar._red;
    final int rStep = green[0] + ((red[0] - green[0]) / 9 * steps).floor();
    final int gStep = green[1] + ((red[1] - green[1]) / 9 * steps).floor();
    final int bStep = green[2] + ((red[2] - green[2]) / 9 * steps).floor();
    final Color backgroundColor = Color.fromRGBO(rStep, gStep, bStep, 1);
    return backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    currentRating = widget._currentRating;
    backgroundColor = _calculateBackgroundColor();
    Widget inkwell = InkWell(
      onTap: () => widget._updateRating(),
      child: SizedBox(
        height: 24,
        width: 24,
        child: Container(
          color: backgroundColor,
        ),
      ),
    );
    return currentRating >= widget._index
        ? inkwell
        : DisabledButton(child: inkwell);
  }
}
