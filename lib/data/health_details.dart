import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/models/health_model.dart';

class HealthDetails{
  final healthData = const[

    HealthModel(title: 'Calories Burned', value: '305', icon: Icons.fireplace),  
    HealthModel(title: 'Steps', value: '3,005', icon: Icons.directions_walk),  
    HealthModel(title: 'Distance', value: '35km', icon: Icons.social_distance),  
    HealthModel(title: 'Sleep', value: '3h45m', icon: Icons.timer_3_outlined),  
    
  ];
}