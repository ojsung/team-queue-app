import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.dart';

class Team {
  Team({required this.name, required this.players});
  final String name;
  final List<PlayerProfile> players;
}
