import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.partial.dart';

class PlayerProfile {
  PlayerProfile({
    required this.playerName,
    required this.playerRating,
    required this.playerId,
  });
  String playerName;
  int playerRating;
  String playerId;
  PlayerProfile update({required PlayerProfilePartial partial}) {
    if (partial.playerName != null && partial.playerName != playerName) {
      playerName = partial.playerName!;
    }
    if (partial.playerRating != null && partial.playerRating != playerRating) {
      playerRating = partial.playerRating!;
    }
    return this;
  }

  PlayerProfilePartial toPartial() {
    return PlayerProfilePartial(
        playerName: playerName,
        playerRating: playerRating,
        playerId: playerId);
  }
}
