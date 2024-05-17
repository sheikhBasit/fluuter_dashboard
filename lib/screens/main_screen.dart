import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluuter_dashboard/util/responsive.dart';
import 'package:fluuter_dashboard/widgets/dashboard_widget.dart';
import 'package:fluuter_dashboard/widgets/side_menu_widget.dart';
import 'package:fluuter_dashboard/widgets/summary_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold
    (
      drawer: Responsive.isMobile(context) ?   SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: SummaryWidget(),
      ):null,
      endDrawer: isDesktop ? const SizedBox(
        width: 250,
        child: SummaryWidget(),
      ):null,
      body: SafeArea(
      child: Row(
        children: [
          if (isDesktop)
          const Expanded(
            flex: 2,
            child: SizedBox(
              child: SideMenuWidget(),
            ),
          ),
          const Expanded(
            flex: 7,
            child: SizedBox(
              child: DashboardWidget(),
            ),
          ),
          if (isDesktop)
          const Expanded(
            flex: 3,
            child: SummaryWidget()
          ),
        ],
      ),
    ));
  }
}