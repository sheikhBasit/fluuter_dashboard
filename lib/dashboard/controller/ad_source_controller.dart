import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/dashboard/model/ad_source.dart';
import 'package:fluuter_dashboard/dashboard/services/firestore_services.dart';
import 'package:get/get.dart';

class AdSourceController extends ChangeNotifier {
  final FirestoreService _firestoreService = Get.find();
  var AdSources = <AdSource>[].obs;

  @override
  void onInit() {
    fetchAdSources();
  }

  void fetchAdSources() async {
    AdSources.assignAll(await _firestoreService.getAdSources());
  }

  Future<void> addAdSource(AdSource adSource) async {
    await _firestoreService.addAdSource(adSource);
    fetchAdSources();
  }

  void removeAdSource(String id) async {
    await _firestoreService.removeAdSource(id);
    fetchAdSources();
  }
}
