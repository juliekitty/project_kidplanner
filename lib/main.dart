import 'package:flutter/material.dart';
import 'package:project_kidplanner/views/bonusTasksView.dart';
//import 'CountDownState.dart';
import 'views/HomePage.dart';
import 'package:project_kidplanner/views/HomePage.dart';

import 'package:project_kidplanner/views/profileView.dart';
//import 'package:project_kidplanner/views/CountDownState.dart';
import 'package:project_kidplanner/views/CountDownTimerView.dart';
import 'package:project_kidplanner/views/advicesView.dart';

import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/components/fab.dart';
import 'package:project_kidplanner/src/components/bottomMenu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowMaterialGrid: true,
      home: LayoutView(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        //primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        iconTheme: IconThemeData(
          color: Colors.cyan[600],
          size: 40,
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.white,
          size: 40,
        ),
        //buttonTheme: ButtonThemeData(),
        fontFamily: 'Futura',
        /*textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),*/
      ),

      //typography:
    );
  }
}

class LayoutView extends StatefulWidget {
  @override
  _LayoutViewState createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _selectedScreenIndex = 0;
  List _screens = [
    {"screen": HomePage(), "title": "Kid Planner"},
    {"screen": CountDownTimer(), "title": "Task Timer"},
    {"screen": ProfileView(), "title": "my Profile"},
    {"screen": AdvicesView(), "title": "Advices"},
    {"screen": BonusTasksView(), "title": "Bonus Tasks"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme,
          _screens[_selectedScreenIndex]["title"]),
      body: Container(
        color: Colors.yellow[100].withOpacity(0.3),
        child: _screens[_selectedScreenIndex]["screen"],
      ),
      extendBody: true,
      bottomNavigationBar: returnBottomNav(_selectedScreenIndex, _selectScreen),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: returnFab(context),
    );
  }
}
