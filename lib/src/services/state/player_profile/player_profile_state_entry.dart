import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.partial.dart';

import '../_classes/state_entry.dart';

import '_classes/player_profile.dart';

class PlayerProfileStateEntry
    implements StateEntry<PlayerProfile, PlayerProfilePartial> {
  // static & factory constructors
  factory PlayerProfileStateEntry(
      {required PlayerProfile profile, bool rebuild = false}) {
    // if rebuild is true, don't use cached value - replace it
    if (rebuild) {
      return _playerProfileStateEntries.update(profile.playerId,
          (value) => PlayerProfileStateEntry._build(profile: profile));
    } else {
      // otherwise use cached value
      return _playerProfileStateEntries.putIfAbsent(profile.playerId,
          () => PlayerProfileStateEntry._build(profile: profile));
    }
  }
  // static properies
  static final Map<String, PlayerProfileStateEntry> _playerProfileStateEntries =
      {};
  // static methods

  // constructors
  PlayerProfileStateEntry._build({
    required PlayerProfile profile,
  }) : _profile = profile;

  // public properties
  @override
  PlayerProfile get value {
    return _profile;
  }

  @override
  set value(PlayerProfile newValue) {
    _profile = newValue;
  }

  @override
  String get key => _profile.playerId;
  //private properties
  PlayerProfile _profile;

  // public methods
  @override
  PlayerProfileStateEntry select() {
    // some async work to in case we need to make api calls
    return this;
  }

  @override
  PlayerProfileStateEntry update({required PlayerProfilePartial value}) {
    if (value.playerName != null && value.playerName!.isNotEmpty) {
      _profile.playerName = value.playerName!;
    }
    if (value.playerRating != null) {
      _profile.playerRating = value.playerRating!;
    }
    return this;
  }
}
