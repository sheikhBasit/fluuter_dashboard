// game_firestore_controller.dart

import 'package:fluuter_dashboard/models/games_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameFirestoreController extends GetxController {
  final games = <Game>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void postDataToFirestore(List<Game> games) async {
    try {
      final collection = FirebaseFirestore.instance.collection('games');
      games.forEach((game) async {
        await collection.add({
          'team1': game.team1,
          'team2': game.team2,
          'scoreTeam1': game.scoreTeam1,
          'scoreTeam2': game.scoreTeam2,
          'date': game.date,
        });
      });
      print('Data posted to Firestore successfully');
      fetchGamesFromFirestore();
    } catch (error) {
      print('Error posting data to Firestore: $error');
    }
  }

  Future<void> fetchGamesFromFirestore() async {
    try {
      final collection = FirebaseFirestore.instance.collection('games');
      QuerySnapshot snapshot = await collection.get();
      if (snapshot.docs.isNotEmpty) {
        games.assignAll(snapshot.docs.map((doc) {
          return Game(
            team1: doc['team1'],
            team2: doc['team2'],
            scoreTeam1: doc['scoreTeam1'],
            scoreTeam2: doc['scoreTeam2'],
            date: doc['date'],
          );
        }));
        printGamesData();
      } else {
        print('No games data available in Firestore');
      }
    } catch (error) {
      print('Error fetching data from Firestore: $error');
    }
  }

  void printGamesData() {
    if (games.isNotEmpty) {
      games.forEach((game) {
        print('Team 1: ${game.team1}, Score 1: ${game.scoreTeam1}');
        print('Team 2: ${game.team2}, Score 2: ${game.scoreTeam2}');
        print('Date: ${game.date}');
        print('-----------------------------');
      });
    } else {
      print('No games data available');
    }
  }
}
