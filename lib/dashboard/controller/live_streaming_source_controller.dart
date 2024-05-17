// controllers/live_streaming_source_controller.dart

import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/dashboard/model/live_streaming_source.dart';
import 'package:fluuter_dashboard/dashboard/services/firestore_services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LiveStreamingSourceController extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<LiveStreamingSource> liveStreamingSources = [];


  Future<void> addDataToFirestore(String url, Map<String, String> headers, Map<String, String> parameters) async {
    try {
      // Make API call to fetch data
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      dynamic responseData = json.decode(response.body);

      // Store API data on Firestore
      await _firestoreService.storeDataFromApi(responseData, 'live_streaming_sources');

      // Fetch live streaming sources from Firestore
      fetchLiveStreamingSources();
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }
  
  Future<List<LiveStreamingSource>> fetchLiveStreamingSources() async {
  liveStreamingSources = await _firestoreService.getLiveStreamingSources();
  return liveStreamingSources;
}


  Future<void> updateIsEnabled(String id, bool isEnabled) async {
    try {
      await _firestoreService.updateLiveStreamingSourceIsEnabled(id, isEnabled);
      fetchLiveStreamingSources();
    } catch (e) {
      print('Error updating isEnabled state: $e');
    }
  }

  Future<void> removeLiveStreamingSource(String id) async {
    await _firestoreService.removeLiveStreamingSource(id);
    fetchLiveStreamingSources();
  }
}
