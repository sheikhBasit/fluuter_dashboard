import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluuter_dashboard/data/side_menu_data.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;  
  @override
  Widget build(BuildContext context) {
  final data  = SideMenuData();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
    child: ListView.builder(
      itemCount: data.menu.length,
      itemBuilder: (context,index) => 
      buildMenuEntry(data, index),
      ),
    );
  }
  
  Widget buildMenuEntry(
    SideMenuData data, int index) {
      final isSelected = selectedIndex == index;
      return InkWell(
        onTap: () => setState(() => selectedIndex = index),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 7.0),
              child: Icon(
                data.menu[index].icon,
                color: isSelected ? Colors.blue : Colors.grey,
                ),
            ),
            Text(data.menu[index].title,
            style: TextStyle(
              fontSize: 16,
              color:isSelected?Colors.blue : Colors.grey,
              fontWeight:isSelected? FontWeight.w600: FontWeight.normal,)  
            ),
          ],
        ),
      );
  }
}