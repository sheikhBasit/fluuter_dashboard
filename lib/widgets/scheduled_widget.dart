import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/data/schedule_tasks_data.dart';
import 'package:fluuter_dashboard/widgets/custom_card.dart';

class ScheduledWidget extends StatelessWidget {
  const ScheduledWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ScheduledTaskData();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Scheduled",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500
        ),
        ),
        SizedBox(height: 12,),
        for (var i = 0; i < data.scheduled.length; i++)
        
          CustomCard(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.scheduled[i].title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                ),
                SizedBox(height: 2,),
                Text(data.scheduled[i].date,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
                ),
                
              ],
            ),
          )
        
          
        ],
    );
  }
}