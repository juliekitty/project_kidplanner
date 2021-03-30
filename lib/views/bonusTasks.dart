import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../src/components/appBar.dart';
import '../src/components/fab.dart';
import '../src/components/bottomMenu.dart';

class BonusTasks extends StatefulWidget {
  @override
  _BonusTasksState createState() => _BonusTasksState();
}

class _BonusTasksState extends State<BonusTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, Theme.of(context).textTheme, 'Bonus Tasks'),
        body: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: returnFab(context),
        bottomNavigationBar: returnBottomNav(context));
  }
}
