import 'package:team_queue_app/src/configuration/navigation/phone_routes.dart';
import 'package:team_queue_app/src/configuration/navigation/subroute.dart';

class SubrouteMap {
  static final Map<PhoneRoutes, Subroute> _subrouteMap = {};
  operator [](PhoneRoutes index) {
    if (_subrouteMap[index] == null) {
      _subrouteMap[index] = Subroute(path: index.route);
    }
    return _subrouteMap[index];
  }
}
