import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../src/components/appBar.dart';
import 'package:project_kidplanner/src/classes/customScrollPhysics.dart';

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/resources/programsData.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

//
//  global variables
//

// bool: is the next button visible
bool isVisibileNextBtn = false;

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

class ProgramDetailsView extends StatefulWidget {
  @override
  _ProgramDetailsViewState createState() => _ProgramDetailsViewState();
}

class _ProgramDetailsViewState extends State<ProgramDetailsView> {
  // State variables
  // Variables for Pageview
  int _selectedScreenIndex = 0; // current screen
  PageController _pageController = PageController();
  // Timer
  Timer timer;
  // List of the screens
  // TODO: construct dynamically with the program.steps
  // and merge the two in one List
  List<Map<String, dynamic>> _screens = [
    {
      "title": "Step 1",
      "widget": new Center(child: step1()),
      "duration": Duration(seconds: 5)
    },
    {
      "title": "Step 2",
      "widget": new Center(child: Step2()),
      "duration": Duration(seconds: 15)
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
  ];

  List<Map<String, dynamic>> initSteps(List<ProgramStep> steps) {
    return _screens;
  }

  List<Widget> initStepsWidgetsList() {
    final List<Widget> _stepsWidgetsList = [];
    _screens.forEach((element) {
      _stepsWidgetsList.add(element['widget']);
    });
    return _stepsWidgetsList;
  }

/*
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }
*/
  // Go back to previous state, at the end of the program or when program interrupted
  void backState() {
    Navigator.pop(context);
  }

  // when the state is left
  @override
  void dispose() {
    print('dispose');
    timer.cancel();
    super.dispose();
  }

  // function called after timer time's up
  void timedAction() {
    debugPrint("timedAction");
    if (_selectedScreenIndex + 1 < _screens.length) {
      /*_pageController.nextPage(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );*/
      debugPrint("Button next visible");
      setState(() {
        isVisibileNextBtn = true;
      });
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
    // If not the last step, program a timer to go to the next step
    print('create timer ${_screens[_selectedScreenIndex]["duration"]}');
    loadTimer(_screens[_selectedScreenIndex]["duration"]);
    _selectedScreenIndex = index;
  }

  @override
  void initState() {
    super.initState();
    print('initState');

    // init variable
    isVisibileNextBtn = false;

    // create first timer
    print(
        'create first timer $_selectedScreenIndex of ${_screens[_selectedScreenIndex]["duration"]}');
    loadTimer(_screens[_selectedScreenIndex]["duration"]);
  }

  @override
  Widget build(BuildContext context) {
    final String programType = ModalRoute.of(context).settings.arguments;
    final Program program = findProgramUsingFirstWhere(programs, programType);

    List _stepsWidgetsList = initStepsWidgetsList();

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
            _screens[_selectedScreenIndex]["title"]),
        body: Container(
          color: Colors.yellow[100].withOpacity(0.3),
          child: PageView(
            children: _stepsWidgetsList,
            pageSnapping: false,
            physics: CustomLockScrollPhysics(lockLeft: true, lockRight: true),
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: (index) {
              onPageChanged(index);
            },
          ),
        ),
        floatingActionButton: (_selectedScreenIndex + 1 >= _screens.length)
            ? Container()
            : Visibility(
                visible: isVisibileNextBtn,
                child: FloatingActionButton.extended(
                  label: Text(
                    "NEXT",
                    style: TextStyle(
                        fontFamily: 'Helvetica', fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(
                    Icons.star,
                    size: Theme.of(context).iconTheme.size - 15,
                  ),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
      ),
    );
  }
}
