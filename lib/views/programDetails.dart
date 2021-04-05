import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../src/components/appBar.dart';
import 'package:project_kidplanner/src/classes/customScrollPhysics.dart';

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/libraries/programsData.dart';
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

List<Widget> initStepsWidgetsList(_screens, context) {
  // createWidget List to use in the PageView
  final List<Widget> _stepsWidgetsList = [];
  // TODO use the programStep infos for widget
  _screens.forEach((element) {
    debugPrint(element.title);
    if (element.widget != null) {
      _stepsWidgetsList.add(element.widget);
    } else {
      _stepsWidgetsList.add(element.stepDefault(context));
    }
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
          _screens = program.steps;
          debugPrint(program.steps.toString());
          _stepsWidgetsList = initStepsWidgetsList(_screens, context);

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
