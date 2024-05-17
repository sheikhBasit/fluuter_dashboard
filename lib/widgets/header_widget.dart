import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/constants/constants.dart';
import 'package:fluuter_dashboard/util/responsive.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(!Responsive.isDesktop(context))
        Padding(padding: const EdgeInsets.all(4.0)
        ,child: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
        )
        ),
        if(!Responsive.isMobile(context))
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              fillColor: cardBackgroundColor,
              filled: true,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:  BorderSide(color: Theme.of(context).primaryColor)),
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
                size: 21,
                ),
            ),
          ),
        ),
      if(Responsive.isMobile(context))
      Row(
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (){},
          ),
          InkWell(
            onTap: (){
              Scaffold.of(context).openEndDrawer();
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                )
              )
            ),
          )
        ],
      ),
      ],
    );
  }
}