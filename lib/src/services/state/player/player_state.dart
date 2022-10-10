// i don't need a whole state management package, i just need something small
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:team_queue_app/src/services/state/_classes/state.dart';

import '_classes/player.dart';
import '_classes/player.partial.dart';

class PlayerState extends ChangeNotifier
    implements ModelState<Player, PlayerPartial> {
  // static and factory constructors
  static PlayerState? _playerProfileState;
  factory PlayerState() {
    _playerProfileState ??= PlayerState._build();
    return _playerProfileState!;
  }

  // public static props
  //private static props
  // constructors
  PlayerState._build();

  // public props
  Map<String, Player> get currentState {
    return _state;
  }
  // private props
  final Map<String, Player> _state = {};

  // public methods
  @override
  Future<Map<String, Player>> getState() async {
    return _state;
  }

  @override
  Future<void> setState({required Map<String, Player> newState}) async {
    _state.clear();
    _state.addAll(newState);
  }

  @override
  Future<List<Player>> select({required List<String> keys}) async {
    final List<Player> entries = [];
    for (var key in keys) {
      final Player? profile = _state[key];
      if (profile == null) {
        throw Exception('Accessing a key that does not exist: $key');
      } else {
        entries.add(profile);
      }
    }
    return entries;
  }

  @override
  Future<List<Player>> update({required List<PlayerPartial> updates}) async {
    final List<Player> updatedEntries = [];
    for (var update in updates) {
      final String key = update.id;
      final Player? entry = _state[key];
      if (entry != null) {
        final Player updatedValue = entry.update(partial: update);
        updatedEntries.add(updatedValue);
      }
    }
    if (updatedEntries.isNotEmpty) {
      notifyListeners();
    }
    // do some bulk push up to api to notify of updates?
    return updatedEntries;
  }

  @override
  Future<List<Player>> insert({required List<Player> values}) async {
    final List<Player> newEntries = [];
    for (var value in values) {
      _state.putIfAbsent(value.id, () {
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
  Future<List<Player>> upsert({required List<Player> values}) async {
    bool alerted = false;
    List<Player> entries = [];
    List<Player> shouldInsert = [];
    for (var value in values) {
      final String key = value.id;
      if (_state.containsKey(key)) {
        final Player entry = _state[key]!;
        final PlayerPartial partial =
            PlayerPartial(id: value.id, name: value.name, rating: value.rating);
        entries.add(entry.update(partial: partial));
      } else {
        shouldInsert.add(value);
      }
    }
    if (shouldInsert.isNotEmpty) {
      entries.addAll(await insert(values: shouldInsert));
      alerted = true;
    }
    if (!alerted) {
      notifyListeners();
    }
    return entries;
  }

  // private methods
}
