import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluuter_dashboard/dashboard/model/ad_source.dart';
import 'package:fluuter_dashboard/dashboard/model/api_key.dart';
import 'package:fluuter_dashboard/dashboard/model/live_streaming_source.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ApiKey>> getApiKeys() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('api_keys').get();
    return snapshot.docs.map((doc) => ApiKey.fromMap(doc.data())).toList();
  }

  Future<void> addApiKey(ApiKey apiKey) async {
    await _firestore.collection('api_keys').add(apiKey.toMap());
  }

  Future<void> removeApiKey(String id) async {
    await _firestore.collection('api_keys').doc(id).delete();
  }

  Future<List<AdSource>> getAdSources() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('ad_sources').get();
    return snapshot.docs.map((doc) => AdSource.fromMap(doc.data())).toList();
  }

  Future<void> addAdSource(AdSource adSource) async {
    await _firestore.collection('ad_sources').add(adSource.toMap());
  }

  Future<void> removeAdSource(String id) async {
    await _firestore.collection('ad_sources').doc(id).delete();
  }

  Future<List<LiveStreamingSource>> getLiveStreamingSources() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('live_streaming_sources').get();
    return snapshot.docs
        .map((doc) => LiveStreamingSource.fromMap(doc.data()))
        .toList();
  }

  Future<void> addLiveStreamingSource(LiveStreamingSource source) async {
    await _firestore
        .collection('live_streaming_sources')
        .add(source.toMap());
  }

  Future<void> removeLiveStreamingSource(String id) async {
    await _firestore.collection('live_streaming_sources').doc(id).delete();
  }

  // Update isEnabled state of a live streaming source in Firestore
  Future<void> updateLiveStreamingSourceIsEnabled(String id, bool isEnabled) async {
    await _firestore.collection('live_streaming_sources').doc(id).update({'isEnabled': isEnabled});
  }
Future<void> storeDataFromApi(dynamic data, String collectionName) async {
  try {
    // Store data in Firestore
    await _firestore.collection(collectionName).add({'data': data});
    print('Data from API stored successfully in Firestore');
    print(data);
  } catch (error) {
    print('Error storing data from API in Firestore: $error');
    // Handle error
  }
}


}
