import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:easy_localization/easy_localization.dart';

Widget returnBottomNav(_selectedScreenIndex, _selectScreen) {
  return BottomAppBar(
    shape: CircularNotchedRectangle(),
    color: Colors.amber,
    notchMargin: 4,
    clipBehavior: Clip.antiAlias,
    child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.amber,
      currentIndex: _selectedScreenIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.cyan,
      iconSize: 30,
      onTap: _selectScreen,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: tr('HP_PageTitle')),
        BottomNavigationBarItem(
            icon: Icon(Icons.hourglass_bottom),
            label: tr('Countdown_PageTitle')),
        //BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        //BottomNavigationBarItem(icon: Icon(Icons.list), label: "Advices"),
        //BottomNavigationBarItem(icon: Icon(Icons.star), label: "Bonus Tasks")
      ],
    ),
  );
}
