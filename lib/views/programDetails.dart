import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../src/components/appBar.dart';
import 'package:project_kidplanner/src/classes/customScrollPhysics.dart';

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/resources/programsData.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

//
//  global variables
//

// bool: is the next button visible
bool isVisibileNextBtn = false;
List _screens;
List _stepsWidgetsList;
// Timer
Timer timer;
bool _initDone = false;

//
// Each step as a widget for the pageView
// TODO: dynamically constructs the steps as Widgets
//
//
Widget step1() {
  return Container(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
      child: Text(
        '1',
      ),
    ),
  );
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

// Widget of the dialog shown when user attempts to interrupt the program
Widget showInterruptDialog(context) {
  return AlertDialog(
    content: Text('Are you sure you want to exit? You\'ll loose your bonus!'),
    actions: <Widget>[
      TextButton(
        child: Text('No'),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      TextButton(
        child: Text('Yes, exit!!'),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
    ],
  );
}

// List of the screens
// and merge the two in one List

List<ProgramStep> initSteps(List<ProgramStep> steps) {
  /*List<Map<String, dynamic>> _screens = [
    {
      "title": "Step 1",
      "widget": new Center(child: step1()),
      "duration": Duration(seconds: 5)
    },
    {
      "title": "Step 2",
      "widget": new Center(child: Step2()),
      "duration": Duration(seconds: 3)
    },
    {
      "title": "Step 3",
      "widget": new Center(child: Step3()),
      "duration": Duration(seconds: 6)
    },
    {
      "title": "Step 4",
      "widget": new Center(child: Step4()),
      "duration": Duration(seconds: 5)
    },
  ];*/

  return steps;
}

List<Widget> initStepsWidgetsList(_screens) {
  // createWidget List to use in the PageView
  final List<Widget> _stepsWidgetsList = [];
  _screens.forEach((element) {
    debugPrint(element.title);
    _stepsWidgetsList.add(element.widget);
  });
  debugPrint(_stepsWidgetsList.toString());
  return _stepsWidgetsList;
}

class ProgramDetailsView extends StatefulWidget {
  @override
  _ProgramDetailsViewState createState() => _ProgramDetailsViewState();
}

class _ProgramDetailsViewState extends State<ProgramDetailsView> {
  // State variables
  // Variables for Pageview
  int _selectedScreenIndex = 0; // current screen
  PageController _pageController = PageController();

  // Go back to previous state
  // at the end of the program or when program interrupted
  void backState() {
    Navigator.pop(context);
  }

  // when the state is left
  @override
  void dispose() {
    debugPrint('dispose');
    debugPrint('timer $timer');
    timer.cancel();
    super.dispose();
  }

  // function called after timer time's up
  // to display next or done button (FloatingActionButton)
  void timedAction() {
    debugPrint("timedAction");
    debugPrint("Button next visible");
    if (this.mounted) {
      setState(() {
        isVisibileNextBtn = true;
      });
    }
  }

  // action on the next button (FloatingActionButton)
  void nextPageOrBack() {
    if (_selectedScreenIndex + 1 < _screens.length) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      // TODO add points to score
    } else {
      backState();
    }
  }

  // create a timer
  void loadTimer(Duration duration) {
    timer = new Timer(duration, timedAction);
  }

  void onPageChanged(index) {
    setState(() {
      isVisibileNextBtn = false;
    });
    _selectedScreenIndex = index;

    // If not the last step, program a timer to go to the next step
    debugPrint(
        'create timer $_selectedScreenIndex of ${_screens[_selectedScreenIndex].duration}');
    loadTimer(_screens[_selectedScreenIndex].duration);
  }

  @override
  void initState() {
    super.initState();
    debugPrint('initState');

    // init variables
    isVisibileNextBtn = false;
    _initDone = false;
  }

  Future<dynamic> callAsyncFetch() => Future.delayed(Duration.zero, () {
        if (!_initDone) {
          _initDone = true;
          final String programType = ModalRoute.of(context).settings.arguments;
          final Program program =
              findProgramUsingFirstWhere(programs, programType);
          debugPrint(program.title);
          _screens = initSteps(program.steps);
          debugPrint(program.steps.toString());
          _stepsWidgetsList = initStepsWidgetsList(_screens);

          // create first timer
          debugPrint(
              'create first timer $_selectedScreenIndex of ${_screens[_selectedScreenIndex].duration}');
          loadTimer(_screens[_selectedScreenIndex].duration);
        }
        return true;
      });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return WillPopScope(
              onWillPop: () async {
                final value = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return showInterruptDialog(context);
                    });

                return value == true;
              },
              child: Scaffold(
                appBar: appBar(context, Theme.of(context).textTheme,
                    _screens[_selectedScreenIndex].title),
                body: Container(
                  color: Colors.yellow[100].withOpacity(0.3),
                  child: PageView(
                    children: _stepsWidgetsList,
                    pageSnapping: false,
                    physics: CustomLockScrollPhysics(
                        lockLeft: true, lockRight: true),
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: (index) {
                      onPageChanged(index);
                    },
                  ),
                ),
                floatingActionButton: Visibility(
                  visible: isVisibileNextBtn,
                  child: FloatingActionButton.extended(
                    label: Text(
                      (_selectedScreenIndex + 1 >= _screens.length)
                          ? "DONE"
                          : "NEXT",
                      style: TextStyle(
                          fontFamily: 'Helvetica', fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(
                      Icons.star,
                      size: Theme.of(context).iconTheme.size - 15,
                    ),
                    onPressed: nextPageOrBack,
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
