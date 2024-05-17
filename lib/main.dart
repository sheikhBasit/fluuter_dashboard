import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/constants/constants.dart';
import 'package:fluuter_dashboard/dashboard/controller/live_streaming_source_controller.dart';
import 'package:fluuter_dashboard/dashboard/controller/ad_source_controller.dart'; // Add import for AdSourceController
import 'package:fluuter_dashboard/dashboard/services/firestore_services.dart';
import 'package:fluuter_dashboard/firebase_options.dart';
import 'package:fluuter_dashboard/screens/admin_dashboard.dart';
import 'package:get/get.dart'; // Import Get package
import 'package:provider/provider.dart';
import 'package:fluuter_dashboard/dashboard/controller/admin_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  // Initialize FirestoreService using GetX
  Get.put(FirestoreService()); // Initialize FirestoreService here

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdminController()),
        ChangeNotifierProvider(create: (_) => LiveStreamingSourceController()),
        ChangeNotifierProvider(create: (_) => AdSourceController()), // Provide AdSourceController here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        brightness: Brightness.dark,
      ),
      home: AdminDashboard(),
    );
  }
}
