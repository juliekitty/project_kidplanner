import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../src/components/appBar.dart';
import '../src/components/fab.dart';
import '../src/components/bottomMenu.dart';

class ProgramView extends StatefulWidget {
  @override
  _ProgramViewState createState() => _ProgramViewState();
}

class _ProgramViewState extends State<ProgramView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, Theme.of(context).textTheme, 'Program'),
        body: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: returnFab(context),
        bottomNavigationBar: returnBottomNav(context));
  }
}
