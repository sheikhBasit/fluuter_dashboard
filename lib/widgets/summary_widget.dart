import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/widgets/pie_chart_widget.dart';
import 'package:fluuter_dashboard/widgets/scheduled_widget.dart';
import 'package:fluuter_dashboard/widgets/summary_details_widget.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        SizedBox(height: 20,),
        Chart(),
        Text("Summary",
        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: SummaryDetailsWidget(),
        ),
        SizedBox(height: 40,),
        ScheduledWidget(),
      ],),
    );
  }
}