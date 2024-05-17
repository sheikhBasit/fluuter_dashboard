import 'package:fluuter_dashboard/models/team_standing.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class StandingsController extends GetxController {
  var isLoading = true.obs;
  var standings = <TeamStanding>[].obs;
  final String season = '2023-2024';
  final String league = '12';

  @override
  void onInit() {
    super.onInit();
    fetchStandingsFromApi(); // Call fetchStandingsFromApi method instead of fetchStandings
  }

  void fetchStandingsFromApi() async {
    try {
      isLoading(true);
      var response = await http.get(
        // Uri.parse('https://api-basketball.p.rapidapi.com/standings?season=$season&league=$league'),
        Uri.parse('https://api-basketba'),
        headers: {
          'X-RapidAPI-Key': 'ab2b93e6aamshd595de95130d219p1aba2djsnd51454b2bdf1',
          'X-RapidAPI-Host': 'api-basketball.p.rapidapi.com',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['response'][0];
        standings.assignAll(List<TeamStanding>.from(data.map((x) {
          final players = x['players'] != null ? x['players']['total'] : 0;
          final wins = x['games'] != null && x['games']['win'] != null ? x['games']['win']['total'] : 0;
          final losses = x['games'] != null && x['games']['lose'] != null ? x['games']['lose']['total'] : 0;
          final winPercentage = (wins / (wins + losses)) * 100; // Calculate win percentage

          return TeamStanding(
            position: x['position'],
            teamName: x['team']['name'].split(' ')[x['team']['name'].split(' ').length - 1],
            groupName: x['group']['name'],
            matchesPlayed: x['games']['played'],
            players: players,
            wins: wins,
            losses: losses,
            winPercentage: winPercentage.isNaN ? 0 : winPercentage,
            logoUrl: x['team']['logo'],
          );
        })));

        isLoading(false);
      }
    } catch (error) {
      print('Error fetching standings from API: $error');
    }
  }

  Future<void> postDataToFirestore(List<TeamStanding> standings) async {
    try {
      final collection = FirebaseFirestore.instance.collection('standings');
      standings.forEach((standing) async {
        await collection.add({
          'position': standing.position,
          'teamName': standing.teamName,
          'groupName': standing.groupName,
          'matchesPlayed': standing.matchesPlayed,
          'players': standing.players,
          'wins': standing.wins,
          'losses': standing.losses,
          'winPercentage': standing.winPercentage,
          'logoUrl': standing.logoUrl,
        });
      });
      print('Data posted to Firestore successfully');
    } catch (error) {
      print('Error posting data to Firestore: $error');
    }
  }

}
