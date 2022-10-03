import 'package:flutter/material.dart';
import 'package:team_queue_app/src/configuration/navigation/phone_routes.dart';
import 'package:team_queue_app/src/views/stats/stats_page.dart';
import 'package:team_queue_app/src/views/team_generator/team_generator_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepOrange,
            primaryColorDark: const Color(0xFFE64A19),
            backgroundColor: Colors.white,
            accentColor: Colors.amber,
            brightness: Brightness.light,
            cardColor: Colors.white70,
            errorColor: Colors.pink.shade100),
      ),
      onGenerateRoute: (settings) {
        if (settings.name == null || settings.name == '/') {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyHomePage(subroute: PhoneRoutes.teamGenerator.route),
              settings: settings);
        } else {
          return null;
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, String? subroute})
      : _subroute = subroute,
        super(key: key);
  final String? _subroute;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  int currentIndex = 0;
  void _onTap(int itemIndex) {
    switch (itemIndex) {
      case 0:
        currentIndex = 0;
        _navigatorKey.currentState!
            .pushReplacementNamed(PhoneRoutes.teamGenerator.route);
        break;
      case 1:
        currentIndex = 1;
        _navigatorKey.currentState!
            .pushReplacementNamed(PhoneRoutes.stats.route);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        initialRoute: widget._subroute,
        onGenerateRoute: (settings) {
          Widget? page;
          if (settings.name!.startsWith(PhoneRoutes.teamGenerator.route)) {
            final String subrouteString = settings.name!
                .substring(PhoneRoutes.teamGenerator.route.length);
            page = TeamGeneratorPage(subroute: subrouteString);
          } else if (settings.name!.startsWith(PhoneRoutes.stats.route)) {
            final String subrouteString =
                settings.name!.substring(PhoneRoutes.stats.route.length);
            page = StatsPage(
              subroute: subrouteString,
            );
          }
          if (page == null) {
            return null;
          }
          return MaterialPageRoute(
            builder: (BuildContext context) => page!,
            settings: settings,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Team Generator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          )
        ],
        onTap: _onTap,
        currentIndex: currentIndex,
      ),
    );
  }
}
