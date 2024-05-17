import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/models/menu_model.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.assessment, title: 'Dashboard'),
    MenuModel(icon: Icons.account_circle, title: 'Profile'),
    MenuModel(icon: Icons.play_for_work_outlined, title: 'Excercise'),
    MenuModel(icon: Icons.history, title: 'History'),
    MenuModel(icon: Icons.settings, title: 'Settings'),
    MenuModel(icon: Icons.exit_to_app, title: 'Logout'),
  ];  
  }