import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../src/components/appBar.dart';

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/resources/programsData.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Step1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: Text(
          '1',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}

class Step2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: Text(
          '2',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}

class Step3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: Text(
          '3',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}

class Step4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
        child: Text(
          '4',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}

class ProgramDetailsView extends StatefulWidget {
  @override
  _ProgramDetailsViewState createState() => _ProgramDetailsViewState();
}

class _ProgramDetailsViewState extends State<ProgramDetailsView> {
  int _selectedScreenIndex = 0;
  List _screens = [
    {"screen": Step1(), "title": "Kid Planner"},
    {"screen": Step2(), "title": "Task Timer"},
    {"screen": Step3(), "title": "my Profile"},
    {"screen": Step4(), "title": "Advices"},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String programType = ModalRoute.of(context).settings.arguments;
    final Program program = findProgramUsingFirstWhere(programs, programType);

    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme,
          _screens[_selectedScreenIndex]["title"]),
      body: Container(
        color: Colors.yellow[100].withOpacity(0.3),
        child: _screens[_selectedScreenIndex]["screen"],
      ),
      floatingActionButton: (_selectedScreenIndex + 1 >= _screens.length)
          ? FloatingActionButton(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : FloatingActionButton(
              child: Icon(
                Icons.star,
                color: Colors.white,
              ),
              onPressed: () {
                _selectScreen(_selectedScreenIndex + 1);
              },
            ),
    );
  }
}
