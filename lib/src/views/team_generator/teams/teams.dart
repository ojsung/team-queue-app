import 'package:flutter/material.dart';
import 'package:team_queue_app/src/services/state/player/_classes/player.dart';

import '_classes/team.dart';

class Teams extends StatefulWidget {
  const Teams({Key? key}) : super(key: key);

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  final Team team1 = Team(id: 'dummy1', name: 'Dummy Team 1', players: [
    Player(name: 'dummy 1', rating: 1, id: '1234'),
    Player(name: 'dummy 2', rating: 1, id: '32345'),
    Player(name: 'dummy 3', rating: 1, id: '36546345')
  ]);
  final Team team2 = Team(id: 'dummy2', name: 'Dummy Team 2', players: [
    Player(id: 'asdf', rating: 2, name: 'ttergsgdfsfer'),
    Player(name: 'asdfqwer', id: '343wert', rating: 3),
    Player(id: '1234', name: 'grqwesdafggq', rating: 4)
  ]);
  final List<Team> teams = [];
  @override
  Widget build(BuildContext context) {
    teams.add(team1);
    teams.add(team2);
    return ListView(
      shrinkWrap: true,
      children: [
        for (var team in teams)
          Column(
            children: [
              Text(team.name),
              ListView(
                shrinkWrap: true,
                children: [
                  for (var member in team.players)
                    Container(
                        child: Row(
                      children: [
                        Text(member.name),
                        Text(member.rating.toString())
                      ],
                    ))
                ],
              )
            ],
          )
      ],
    );
  }
}
