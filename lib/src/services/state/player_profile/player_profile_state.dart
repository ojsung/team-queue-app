// i don't need a whole state management package, i just need something small
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:team_queue_app/src/services/state/_classes/state.dart';
import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.dart';
import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.partial.dart';

class PlayerProfileState extends ChangeNotifier
    implements ModelState<PlayerProfile, PlayerProfilePartial> {
  // static and factory constructors
  static PlayerProfileState? _playerProfileState;
  factory PlayerProfileState() {
    _playerProfileState ??= PlayerProfileState._build();
    return _playerProfileState!;
  }

  // public static props
  //private static props
  // constructors
  PlayerProfileState._build();

  // public props
  // private props
  final Map<String, PlayerProfile> _state = {};

  // public methods
  @override
  Future<Map<String, PlayerProfile>> getState() async {
    return _state;
  }

  @override
  Future<void> setState({required Map<String, PlayerProfile> newState}) async {
    _state.clear();
    _state.addAll(newState);
  }

  @override
  Future<List<PlayerProfile>> select({required List<String> keys}) async {
    final List<PlayerProfile> entries = [];
    for (var key in keys) {
      final PlayerProfile? profile = _state[key];
      if (profile == null) {
        throw Exception('Accessing a key that does not exist: $key');
      } else {
        entries.add(profile);
      }
    }
    return entries;
  }

  @override
  Future<List<PlayerProfile>> update(
      {required List<PlayerProfilePartial> updates}) async {
    final List<PlayerProfile> updatedEntries = [];
    for (var update in updates) {
      final String key = update.playerId;
      final PlayerProfile? entry = _state[key];
      if (entry != null) {
        final PlayerProfile updatedValue = entry.update(partial: update);
        updatedEntries.add(updatedValue);
        notifyListeners();
      }
    }
    // do some bulk push up to api to notify of updates?
    return updatedEntries;
  }

  @override
  Future<List<PlayerProfile>> insert(
      {required List<PlayerProfile> values}) async {
    final List<PlayerProfile> newEntries = [];
    for (var value in values) {
      _state.putIfAbsent(value.playerId, () {
        newEntries.add(value);
        return value;
      });
    }
    notifyListeners();
    // bulk push to api to notify of new entries
    return newEntries;
  }

  @override
  Future<List<String>> delete({required List<String> keys}) async {
    final List<String> deletedKeys = [];
    _state.removeWhere((key, _) => keys.contains(key));
    // api call to delete
    notifyListeners();
    return deletedKeys;
  }

  @override
  Future<List<PlayerProfile>> upsert(
      {required List<PlayerProfile> values}) async {
    List<PlayerProfile> entries = [];
    for (var value in values) {
      final String key = value.playerId;
      _state.update(key, (value) => value.update(partial: value.toPartial()));
      if (_state.containsKey(key)) {
        final PlayerProfile entry = _state[key]!;
        final PlayerProfilePartial partial = PlayerProfilePartial(
            playerId: value.playerId,
            playerName: value.playerName,
            playerRating: value.playerRating);
        entries.add(entry.update(partial: partial));
      } else {
        final PlayerProfile entry = (await insert(values: [value]))[0];
        entries.add(entry);
      }
    }
    notifyListeners();
    return entries;
  }

  // private methods
}
