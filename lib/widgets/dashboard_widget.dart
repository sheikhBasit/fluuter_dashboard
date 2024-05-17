import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/util/responsive.dart';
import 'package:fluuter_dashboard/widgets/activity_details_card.dart';
import 'package:fluuter_dashboard/widgets/bar_graph_card.dart';
import 'package:fluuter_dashboard/widgets/header_widget.dart';
import 'package:fluuter_dashboard/widgets/liner_chart_card.dart';
import 'package:fluuter_dashboard/widgets/summary_widget.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
        ),
        child: Column(
          children: [
            const SizedBox(height: 18,),
            const HeaderWidget(),
            const SizedBox(height: 18,),
            const ActivityDetailsCard(),
            const SizedBox(height: 18,),
            const LinerChartCard(),
            const SizedBox(height: 18,),
            const BarGraphCard(),
            const SizedBox(height: 18,),
            if(Responsive.isTablet(context))
            const SummaryWidget()
          ],
        ),
      ),
    );
  }
}