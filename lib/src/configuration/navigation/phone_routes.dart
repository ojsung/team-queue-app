import 'package:team_queue_app/src/configuration/navigation/subroute.dart';
import 'package:team_queue_app/src/configuration/navigation/subroute_map.dart';

// I don't see this app getting large enough that looping string operations will ever be a problem
// Because of that, I'm going to go with ease of use over performance --- this should really only ever
// be a performance problem if we get like... 1000+ routes lol. that'll probably never happen
enum PhoneRoutes {
  home,
  // Team Generator Pages
  teamGeneratorBase,
  teamGenerator,
  playerSetup,
  teamSetup,
  teams,
  // Stats Pages
  statsBase,
  stats;

  static PhoneRoutes findPhoneRoute(String routeName) {
    PhoneRoutes foundRoute = PhoneRoutes.home;
    for (var route in PhoneRoutes.values) {
      if (route.name == routeName) {
        foundRoute = route;
        break;
      }
    }
    return foundRoute;
  }
}

extension RouteNameOperations on PhoneRoutes {
  static final SubrouteMap _subrouteMap = SubrouteMap();

  String get route {
    switch (this) {
      case PhoneRoutes.home:
        return '/';

      // Team Generator Routes
      case PhoneRoutes.teamGeneratorBase:
        return '/team-generator';
      case PhoneRoutes.teamGenerator:
        return 'team-generator';
      case PhoneRoutes.playerSetup:
        return 'player-setup';
      case PhoneRoutes.teamSetup:
        return 'team-setup';
      case PhoneRoutes.teams:
        return 'teams';

      // Stats Routes
      case PhoneRoutes.statsBase:
        return '/stats';
      case PhoneRoutes.stats:
        return 'stats';
    }
  }

  Subroute get subroute {
    return _subrouteMap[this];
  }
}
