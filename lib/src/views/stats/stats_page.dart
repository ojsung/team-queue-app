import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key, String? subroute})
      : _subroute = subroute,
        super(key: key);
  final String? _subroute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats'),
      ),
      body: Center(
        child: Text('idk probably some really cool graphs'),
      ),
    );
  }
}
