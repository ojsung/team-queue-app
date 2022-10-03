import 'package:flutter/material.dart';
import 'package:team_queue_app/src/services/state/player_profile/_classes/player_profile.dart';

import '_classes/team.dart';

class Teams extends StatefulWidget {
  const Teams({Key? key}) : super(key: key);

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  final Team team1 = Team(name: 'Dummy Team 1', players: [
    PlayerProfile(playerName: 'dummy 1', playerRating: 1, playerId: '1234'),
    PlayerProfile(playerName: 'dummy 2', playerRating: 1, playerId: '32345'),
    PlayerProfile(playerName: 'dummy 3', playerRating: 1, playerId: '36546345')
  ]);
  final Team team2 = Team(name: 'Dummy Team 2', players: [
    PlayerProfile(
        playerId: 'asdf', playerRating: 2, playerName: 'ttergsgdfsfer'),
    PlayerProfile(playerName: 'asdfqwer', playerId: '343wert', playerRating: 3),
    PlayerProfile(playerId: '1234', playerName: 'grqwesdafggq', playerRating: 4)
  ]);
  final List<Team> teams = [];
  Widget build(BuildContext context) {
    teams.add(team1);
    teams.add(team2);
    return ListView(
      shrinkWrap: true,
      children: [
      for (var team in teams)
      Column(children: [
        Text(team.name),
        ListView(
          shrinkWrap: true,
          children: [
          for (var member in team.players)
          Container(child: Row(children: [
            Text(member.playerName),
            Text(member.playerRating.toString())
          ],)) 
        ],)
      ],)
    ],);
  }
}
