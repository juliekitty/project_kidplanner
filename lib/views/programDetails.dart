import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../src/components/appBar.dart';

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/resources/programsData.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

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
    {"screen": Step1(), "title": "Step 1"},
    {"screen": Step2(), "title": "Step 2"},
    {"screen": Step3(), "title": "Step 3"},
    {"screen": Step4(), "title": "Step 4"},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  Timer stateTimer;

  void loadPeriodic() {
    // runs every 5 second
    stateTimer = Timer.periodic(new Duration(seconds: 2), (timer) {
      debugPrint(timer.tick.toString());
      if (_selectedScreenIndex + 1 < _screens.length) {
        _selectScreen(timer.tick);
      } else {
        endTimer();
      }
    });
  }

  void endTimer() {
    stateTimer?.cancel();
    Navigator.pop(context);
  }

  void loadTimer(Duration duration) {
    Timer timer = new Timer(duration, () {
      debugPrint("Print after 5 seconds");
      if (_selectedScreenIndex + 1 < _screens.length) {
        _selectScreen(_selectedScreenIndex + 1);
      } else {
        backState();
      }
    });
  }

  void backState() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    //stateTimer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // if put here, the function will be called only once
    // loadPeriodic();
  }

  @override
  Widget build(BuildContext context) {
    final String programType = ModalRoute.of(context).settings.arguments;
    final Program program = findProgramUsingFirstWhere(programs, programType);

    // If not the last step, program a timer to go to the next step
    print('create a timer');
    loadTimer(new Duration(seconds: 5));

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
