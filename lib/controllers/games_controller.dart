// // games_controller.dart

// import 'dart:convert';
// import 'package:fluuter_dashboard/models/games_model.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'game_firestore_controller.dart'; // Import the GameFirestoreController

// class GamesController extends GetxController {
//   var isLoading = true.obs;
//   var games = <Game>[].obs;
//   final String date = '2019-11-26';

//   bool _hasFetchedData = false;

//   final GameFirestoreController firestoreController = GameFirestoreController();

//   @override
//   void onInit() {
//     super.onInit();
//     if (!_hasFetchedData) {
//       fetchGamesFromApi();
//     }
//   }

//   void fetchGamesFromApi() async {
//     try {
//       isLoading(true);
//       var response = await http.get(
//         Uri.parse('https://api-basketball.p.rapidapi.com/games/date=$date'),
//         headers: {
//           'X-RapidAPI-Key': 'ab2b93e6aamshd595de95130d219p1aba2djsnd51454b2bdf1',
//           'X-RapidAPI-Host': 'api-basketball.p.rapidapi.com',
//         },
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body)['response'];
//         if (data != null) {
//           games.assignAll(List<Game>.from(data.map((x) {
//             return Game(
//               team1: x['team1'],
//               team2: x['team2'],
//               scoreTeam1: x['scoreTeam1'],
//               scoreTeam2: x['scoreTeam2'],
//               date: x['date'],
//             );
//           })));
//           _hasFetchedData = true;
//           isLoading(false);
//           firestoreController.postDataToFirestore(games); // Call the Firestore controller's method
//         }
//       }
//     } catch (error) {
//       print('Error fetching games from API: $error');
//     }
//   }
// }
