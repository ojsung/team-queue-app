import 'package:flutter/material.dart';

class PlayerRatingForm extends StatefulWidget {
  PlayerRatingForm(
      {Key? key, initialRating = 0, required void Function(int) saveRating})
      : _initialRating = initialRating,
        _saveRating = saveRating,
        super(key: key) {
    _initialRating;
  }
  final Function(int) _saveRating;
  final int _initialRating;

  @override
  State<PlayerRatingForm> createState() => _PlayerRatingFormState();
}

class _PlayerRatingFormState extends State<PlayerRatingForm> {
  int currentRating = 0;
  void _updateRating(int rating) {
    currentRating = rating;
    widget._saveRating(rating);
  }

  @override
  Widget build(BuildContext context) {
    currentRating = widget._initialRating;
    return SizedBox(
      height: 24,
      width: 130,
      child: Row(
        children: [
          for (var i = 1; i <= 10; i++)
            RatingBar(
              index: i,
              updateRating: _updateRating,
              currentRating: currentRating,
            )
        ],
      ),
    );
  }
}

class RatingBar extends StatefulWidget {
  RatingBar({
    Key? key,
    required int index,
    required void Function(int) updateRating,
    required currentRating,
  })  : _index = index,
        _updateRating = updateRating,
        _backgroundColor = (_green + (_red - _green) * index / 10).floor(),
        super(key: key);
  static const int _red = 0x00FF5733;
  static const int _green = 0x0033FF57;
  final int _index;
  final void Function(int) _updateRating;
  final int _backgroundColor;

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget._updateRating(widget._index),
      child: SizedBox(
        height: 24,
        width: 24,
        child: Container(
          color: Color(widget._backgroundColor),
        ),
      ),
    );
  }
}
