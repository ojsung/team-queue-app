
import '../_classes/state_entry.dart';

import '_classes/player.dart';
import '_classes/player.partial.dart';

class PlayerStateEntry implements StateEntry<Player, PlayerPartial> {
  // static & factory constructors
  factory PlayerStateEntry(
      {required Player profile, bool rebuild = false}) {
    // if rebuild is true, don't use cached value - replace it
    if (rebuild) {
      return _playerProfileStateEntries.update(profile.id,
          (value) => PlayerStateEntry._build(profile: profile));
    } else {
      // otherwise use cached value
      return _playerProfileStateEntries.putIfAbsent(
          profile.id, () => PlayerStateEntry._build(profile: profile));
    }
  }
  // static properies
  static final Map<String, PlayerStateEntry> _playerProfileStateEntries =
      {};
  // static methods

  // constructors
  PlayerStateEntry._build({
    required Player profile,
  }) : _profile = profile;

  // public properties
  @override
  Player get value {
    return _profile;
  }

  @override
  set value(Player newValue) {
    _profile = newValue;
  }

  @override
  String get key => _profile.id;
  //private properties
  Player _profile;

  // public methods
  @override
  PlayerStateEntry select() {
    // some async work to in case we need to make api calls
    return this;
  }

  @override
  PlayerStateEntry update({required PlayerPartial value}) {
    if (value.name != null && value.name!.isNotEmpty) {
      _profile.name = value.name!;
    }
    if (value.rating != null) {
      _profile.rating = value.rating!;
    }
    return this;
  }
}
