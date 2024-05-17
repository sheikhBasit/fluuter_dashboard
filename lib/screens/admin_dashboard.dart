import 'package:flutter/material.dart';

import 'package:fluuter_dashboard/screens/ad_section.dart';
import 'package:fluuter_dashboard/screens/api_section.dart';
import 'package:fluuter_dashboard/screens/stream_section.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Define the number of tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        bottom: TabBar(
          controller: _tabController,
          tabs:const [
            Tab(text: 'API'),
            Tab(text: 'Live Stream'),
            Tab(text: 'Advertisement'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ApiKeySection(),
          LiveStreamingSourceSection(),
          AdSourceSection(),
        ],
      ),
    );
  }
}
