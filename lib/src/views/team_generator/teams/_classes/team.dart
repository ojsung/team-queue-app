import 'package:team_queue_app/src/services/state/player/_classes/player.dart';
import 'package:team_queue_app/src/views/widgets/_classes/listable.dart';

class Team implements Listable {
  Team({required this.name, required this.players, required this.id});
  @override
  final String name;
  final List<Player> players;
  @override
  final String id;
}
