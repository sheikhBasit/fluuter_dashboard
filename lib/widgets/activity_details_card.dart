import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/data/health_details.dart';
import 'package:fluuter_dashboard/util/responsive.dart';
import 'package:fluuter_dashboard/widgets/custom_card.dart';

class ActivityDetailsCard extends StatelessWidget {
  const ActivityDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final healtDetails = HealthDetails();
    return GridView.builder(
      itemCount: healtDetails.healthData.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        
        crossAxisCount: Responsive.isMobile(context)?2:4,
        crossAxisSpacing: Responsive.isMobile(context)?12:15,
        mainAxisSpacing: 12,
        ), 
      
      itemBuilder: (context,index) => 
      CustomCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon( 
              healtDetails.healthData[index].icon, 
              size: 30,            
              weight: 30,

            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 4),
              child: Text(
                healtDetails.healthData[index].title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            
          ],
        ),
      ),);
  }
}