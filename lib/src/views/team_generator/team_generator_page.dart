import 'package:flutter/material.dart';
import 'package:team_queue_app/src/services/state/player_profile/player_profile_state.dart';

import 'player_setup/player_setup.dart';
import 'team_setup/team_setup.dart';

class TeamGeneratorPage extends StatefulWidget {
  TeamGeneratorPage({Key? key, String? subroute})
      : _subroute =
            subroute == null || subroute == '' ? 'player-setup' : subroute,
        super(key: key);
  final String _subroute;
  final _navigatorKey = GlobalKey<NavigatorState>();
  final PlayerProfileState _state = PlayerProfileState();
  @override
  State<TeamGeneratorPage> createState() => _TeamGeneratorPageState();
}

class _TeamGeneratorPageState extends State<TeamGeneratorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Generator'),
      ),
      body: Navigator(
        key: widget._navigatorKey,
        initialRoute: widget._subroute,
        onGenerateRoute: (settings) {
          debugPrint(settings.name);
          WidgetBuilder builder;
          switch (settings.name) {
            case 'player-setup':
              builder = (BuildContext context) => PlayerSetup(state: widget._state);
              break;
            case 'team-setup':
              builder = (BuildContext context) => TeamSetup();
              break;
            default:
              throw Exception('Route ${settings.name} not implemented');
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
