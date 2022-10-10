import 'package:flutter/material.dart';
import 'package:team_queue_app/src/configuration/navigation/phone_routes.dart';
import 'package:team_queue_app/src/services/state/player/player_state.dart';

import 'player_setup/player_setup.dart';
import 'team_setup/team_setup.dart';
import 'teams/teams.dart';

class TeamGeneratorPage extends StatefulWidget {
  TeamGeneratorPage({Key? key, String? subroute})
      : _subroute =
            subroute == null || subroute == '' ? 'player-setup' : subroute,
        super(key: key);
  final String _subroute;
  final _navigatorKey = GlobalKey<NavigatorState>();
  final PlayerState _state = PlayerState();

  void navToTeamSetup() {
    _navigatorKey.currentState?.pushNamed(PhoneRoutes.teamSetup.route);
  }

  void navToPlayerSetup() {
    _navigatorKey.currentState?.pushNamed(PhoneRoutes.playerSetup.route);
  }

  void navToTeams() {
    _navigatorKey.currentState?.pushNamed(PhoneRoutes.teams.route);
  }

  @override
  State<TeamGeneratorPage> createState() => _TeamGeneratorPageState();
}

class _TeamGeneratorPageState extends State<TeamGeneratorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Generator'),
      ),
      body: Navigator(
        key: widget._navigatorKey,
        initialRoute: widget._subroute,
        onGenerateRoute: (settings) {
          debugPrint(settings.name);
          WidgetBuilder builder;
          switch (settings.name) {
            case 'player-setup':
              builder = (BuildContext context) => PlayerSetup(
                    state: widget._state,
                    goNext: widget.navToTeamSetup,
                  );
              break;
            case 'team-setup':
              builder = (BuildContext context) => TeamSetup(
                    goBack: widget.navToPlayerSetup,
                    goNext: widget.navToTeams,
                  );
              break;
            case 'teams':
              builder = (BuildContext context) => Teams();
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
