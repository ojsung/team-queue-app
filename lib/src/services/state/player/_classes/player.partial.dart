import 'package:team_queue_app/src/views/widgets/_classes/listable.dart';

import 'player.dart';

class PlayerPartial extends Object {
  PlayerPartial({
    this.name,
    this.rating,
    required this.id,
  });
  String? name;
  int? rating;
  String id;
  Player? toPlayer() {
    if (name != null && name!.isNotEmpty && rating != null) {
      return Player(
        id: id,
        name: name!,
        rating: rating!,
      );
    }
    return null;
  }
}
