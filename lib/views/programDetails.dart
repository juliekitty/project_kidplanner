import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../src/components/appBar.dart';

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/resources/programsData.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

/// Custom page scroll physics
// ignore: must_be_immutable
class CustomLockScrollPhysics extends ScrollPhysics {
  /// Lock swipe on drag-drop gesture
  /// If it is a user gesture, [applyPhysicsToUserOffset] is called before [applyBoundaryConditions];
  /// If it is a programming gesture eg. `controller.animateTo(index)`, [applyPhysicsToUserOffset] is not called.
  bool _lock = false;

  /// Lock scroll to the left
  final bool lockLeft;

  /// Lock scroll to the right
  final bool lockRight;

  /// Creates physics for a [PageView].
  /// [lockLeft] Lock scroll to the left
  /// [lockRight] Lock scroll to the right
  CustomLockScrollPhysics(
      {ScrollPhysics parent, this.lockLeft = false, this.lockRight = false})
      : super(parent: parent);

  @override
  CustomLockScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomLockScrollPhysics(
        parent: buildParent(ancestor),
        lockLeft: lockLeft,
        lockRight: lockRight);
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if ((lockRight && offset < 0) || (lockLeft && offset > 0)) {
      _lock = true;
      return 0.0;
    }

    return offset;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw FlutterError(
            '$runtimeType.applyBoundaryConditions() was called redundantly.\n'
            'The proposed new position, $value, is exactly equal to the current position of the '
            'given ${position.runtimeType}, ${position.pixels}.\n'
            'The applyBoundaryConditions method should only be called when the value is '
            'going to actually change the pixels, otherwise it is redundant.\n'
            'The physics object in question was:\n'
            '  $this\n'
            'The position object in question was:\n'
            '  $position\n');
      }
      return true;
    }());

    /*
     * Handle the hard boundaries (min and max extents)
     * (identical to ClampingScrollPhysics)
     */
    // under-scroll
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    // over-scroll
    else if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) {
      return value - position.pixels;
    }
    // hit top edge
    else if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.pixels;
    }
    // hit bottom edge
    else if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) {
      return value - position.pixels;
    }

    var isGoingLeft = value <= position.pixels;
    var isGoingRight = value >= position.pixels;
    if (_lock && ((lockLeft && isGoingLeft) || (lockRight && isGoingRight))) {
      _lock = false;
      return value - position.pixels;
    }

    return 0.0;
  }
}

/*class Step1 extends StatelessWidget {
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
}*/

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

class ProgramDetailsView extends StatefulWidget {
  @override
  _ProgramDetailsViewState createState() => _ProgramDetailsViewState();
}

class _ProgramDetailsViewState extends State<ProgramDetailsView> {
  int _selectedScreenIndex = 0;

  PageController _pageController = PageController();

  Timer timer;

  List<Map> _screens = [
    {"screen": step1(), "title": "Step 1", "duration": Duration(seconds: 5)},
    {"screen": Step2(), "title": "Step 2", "duration": Duration(seconds: 15)},
    {"screen": Step3(), "title": "Step 3", "duration": Duration(seconds: 6)},
    {"screen": Step4(), "title": "Step 4", "duration": Duration(seconds: 5)},
  ];

  List<Widget> _widgetsList = <Widget>[
    new Center(child: step1()),
    new Center(child: Step2()),
    new Center(child: Step3()),
    new Center(child: Step4()),
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  void loadTimer(Duration duration) {
    timer = new Timer(duration, () {
      debugPrint("Print after ${duration.toString()}");
      if (_selectedScreenIndex + 1 < _screens.length) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
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
    print('dispose');
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print('initState');

    // create first timer
    print(
        'create first timer $_selectedScreenIndex of ${_screens[_selectedScreenIndex]["duration"]}');
    loadTimer(_screens[_selectedScreenIndex]["duration"]);
  }

  @override
  Widget build(BuildContext context) {
    final String programType = ModalRoute.of(context).settings.arguments;
    final Program program = findProgramUsingFirstWhere(programs, programType);
    var steps = program.steps;

    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    'Are you sure you want to exit? You\'ll loose your bonus!'),
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
            });

        return value == true;
      },
      child: Scaffold(
        appBar: appBar(context, Theme.of(context).textTheme,
            _screens[_selectedScreenIndex]["title"]),
        body: Container(
          color: Colors.yellow[100].withOpacity(0.3),
          //child: _screens[_selectedScreenIndex]["screen"],
          child: PageView(
            children: _widgetsList,
            //scrollDirection: Axis.horizontal,
            pageSnapping: false,
            physics: CustomLockScrollPhysics(lockLeft: true, lockRight: true),
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: (index) {
              print("Current page indexber is " + index.toString());
              // If not the last step, program a timer to go to the next step
              print(
                  'create a timer $_selectedScreenIndex of ${_screens[_selectedScreenIndex]["duration"]}');
              loadTimer(_screens[_selectedScreenIndex]["duration"]);
              _selectedScreenIndex = index;
            },
          ),
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
      ),
    );
  }
}
