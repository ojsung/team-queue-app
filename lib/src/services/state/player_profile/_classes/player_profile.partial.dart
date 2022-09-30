import 'player_profile.dart';

class PlayerProfilePartial extends Object {
  PlayerProfilePartial({
    this.playerName,
    this.playerRating,
    required this.playerId,
  });
  String? playerName;
  int? playerRating;
  String playerId;
  PlayerProfile? toPlayerProfile() {
    if (playerName != null && playerName!.isNotEmpty && playerRating != null) {
      return PlayerProfile(
        playerId: playerId,
        playerName: playerName!,
        playerRating: playerRating!,
      );
    }
    return null;
  }
}
