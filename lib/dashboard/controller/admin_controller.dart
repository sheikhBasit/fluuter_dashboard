import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // Import Material.dart for ChangeNotifier
import 'package:fluuter_dashboard/dashboard/model/ad_source.dart';
import 'package:fluuter_dashboard/dashboard/model/api_key.dart';
import 'package:fluuter_dashboard/dashboard/model/live_streaming_source.dart';

// Extend ChangeNotifier
class AdminController extends ChangeNotifier {
  final CollectionReference apiKeyCollection =
      FirebaseFirestore.instance.collection('api_keys');
  final CollectionReference adSourceCollection =
      FirebaseFirestore.instance.collection('ad_sources');
  final CollectionReference liveStreamingSourceCollection =
      FirebaseFirestore.instance.collection('live_streaming_sources');
  final CollectionReference populationDataCollection =
      FirebaseFirestore.instance.collection('population_data');

  Future<void> addApiKey(ApiKey apiKey) async {
    await apiKeyCollection.add({
      'apiKey': apiKey.url,
    });
  }

  Future<void> removeApiKey(String apiKeyId) async {
    await apiKeyCollection.doc(apiKeyId).delete();
  }

  Future<void> toggleAdSource(AdSource adSource) async {
    await adSourceCollection.doc(adSource.id).update({
      'isEnabled': adSource.isEnabled,
    });
  }

  Future<void> addAdSource(AdSource adSource) async {
    await adSourceCollection.add(adSource.toMap());
  }

  Future<void> removeAdSource(String adSourceId) async {
    await adSourceCollection.doc(adSourceId).delete();
  }

  Future<void> addLiveStreamingSource(LiveStreamingSource source) async {
    await liveStreamingSourceCollection.add(source.toMap());
  }

  Future<void> removeLiveStreamingSource(String sourceId) async {
    await liveStreamingSourceCollection.doc(sourceId).delete();
  }

  // Define getters for apiKeys, adSources, and liveStreamingSources
  Future<List<ApiKey>> get apiKeys async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await apiKeyCollection.get() as QuerySnapshot<Map<String, dynamic>>;
    return snapshot.docs
        .map((doc) => ApiKey.fromMap(doc.data()))
        .toList();
  }

  Future<List<AdSource>> get adSources async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await adSourceCollection.get() as QuerySnapshot<Map<String, dynamic>>;
    return snapshot.docs
        .map((doc) => AdSource.fromMap(doc.data()))
        .toList();
  }

  Future<List<LiveStreamingSource>> get liveStreamingSources async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await liveStreamingSourceCollection.get() as QuerySnapshot<Map<String, dynamic>>;
    return snapshot.docs
        .map((doc) => LiveStreamingSource.fromMap(doc.data()))
        .toList();
  }
}
