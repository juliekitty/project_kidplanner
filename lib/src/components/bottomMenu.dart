import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget returnBottomNav(context) {
  final List routes = ['/', '/CountDownTimer'];
  int _selectedScreenIndex = 0;

  void _selectScreen(int index) {
    Navigator.pushNamed(context, routes[index]);
  }

  return BottomAppBar(
    shape: const CircularNotchedRectangle(),
    color: Colors.amber,
    notchMargin: 4,
    clipBehavior: Clip.antiAlias,
    child: BottomNavigationBar(
      elevation: 0,
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
            icon: const Icon(Icons.home), label: tr('HP_PageTitle')),
        BottomNavigationBarItem(
            icon: const Icon(Icons.hourglass_bottom),
            label: tr('Countdown_PageTitle')),
        //BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        //BottomNavigationBarItem(icon: Icon(Icons.list), label: "Advices"),
        //BottomNavigationBarItem(icon: Icon(Icons.star), label: "Bonus Tasks")
      ],
    ),
  );
}
