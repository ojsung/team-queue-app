import 'package:team_queue_app/src/views/widgets/_classes/listable.dart';

import 'player.partial.dart';

class Player implements Listable {
  Player({
    required this.name,
    required this.rating,
    required this.id,
  });
  int rating;
  @override
  String name;
  @override
  String id;
  Player update({required PlayerPartial partial}) {
    if (partial.name != null && partial.name != name) {
      name = partial.name!;
    }
    if (partial.rating != null && partial.rating != rating) {
      rating = partial.rating!;
    }
    return this;
  }

  PlayerPartial toPartial() {
    return PlayerPartial(name: name, rating: rating, id: id);
  }
}
