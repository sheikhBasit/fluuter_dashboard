import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/widgets/custom_card.dart';

class SummaryDetailsWidget extends StatelessWidget {
  const SummaryDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: Color(0xFF2F353E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildDetails('Cal', '2000'),
        buildDetails('Protein', '200g'),
        buildDetails('Fat', '100g'),
        buildDetails('Carbs', '300g'),     
      ],
      ),
    );
  }
  
 Widget buildDetails(
  String key,  String value
 ) {
  return Column(
    children: [
      Text(key,
      style: TextStyle(
        fontSize: 11,
        color: Colors.grey
      ),
      ),
      SizedBox(height: 8,),
      Text(value,
      style: TextStyle(
        fontSize: 14,
      ),
      ),
    ],
  );
 }
}