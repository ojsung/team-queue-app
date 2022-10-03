import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key, String? subroute})
      : _subroute = subroute,
        super(key: key);
  final String? _subroute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats $_subroute'),
      ),
      body: const Center(
        child: Text('idk probably some really cool graphs'),
      ),
    );
  }
}
