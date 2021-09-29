import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/classes/customScrollPhysics.dart';
import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/libraries/programsData.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

//
//  global variables
//

// bool: is the next button visible
bool isVisibileNextBtn = false;
late List _screens;
List _stepsWidgetsList = [];
// Timer
late Timer timer;
bool _initDone = false;

// Widget of the dialog shown when user attempts to interrupt the program
Widget showInterruptDialog(context) {
  return AlertDialog(
    content: const Text('Programs.programInterrupt').tr(),
    actions: <Widget>[
      TextButton(
        child: const Text('General_no').tr(),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
      TextButton(
        child: const Text('Programs.programInterrupt_yes').tr(),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
    ],
  );
}

List<Widget?> initStepsWidgetsList(_screens, context, _controller) {
  // createWidget List to use in the PageView
  final List<Widget> _stepsWidgetsList = [];
  // TODO use the programStep infos for widget
  _screens.forEach((element) {
    if (element.widget != null) {
      _stepsWidgetsList.add(element.widget);
    } else {
      _stepsWidgetsList.add(element.stepDefault(context, _controller));
    }
  });
  if (_stepsWidgetsList.isEmpty) {
    _stepsWidgetsList.add(Container());
  }
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
  final PageController _pageController = PageController();

  // Animation
  final CountDownController _controller = CountDownController();
  // Audio
  static AudioCache player = AudioCache(
      prefix: globals.audioFilesPrefix, fixedPlayer: globals.audioPlayer);

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
    globals.audioPlayer.stop();
    super.dispose();
  }

  // function called after timer time's up
  // to display next or done button (FloatingActionButton)
  void timedAction() {
    debugPrint("timedAction");
    debugPrint("Button next visible");
    if (mounted) {
      setState(() {
        isVisibileNextBtn = true;
        player.play(globals.timerFinishedAudio);
      });
    }
  }

  // action on the next button (FloatingActionButton)
  void nextPageOrBack() {
    globals.audioPlayer.stop();
    if (_selectedScreenIndex + 1 < _screens.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() {
        globals.currentParticipant.addToScore(500);
      });
    } else {
      backState();
    }
  }

  // create a timer
  void loadTimer(Duration duration) {
    timer = Timer(duration, timedAction);
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
        print('callAsyncFetch');
        if (!_initDone) {
          print('!_initDone');
          _initDone = true;
          final String? programType =
              ModalRoute.of(context)!.settings.arguments as String?;
          final Program program =
              findProgramUsingFirstWhere(programs, programType)!;
          debugPrint(program.title);
          _screens = program.steps;
          _stepsWidgetsList =
              initStepsWidgetsList(_screens, context, _controller);
          // create first timer
          debugPrint(
              'create first timer $_selectedScreenIndex of ${_screens[_selectedScreenIndex].duration}');
          loadTimer(_screens[_selectedScreenIndex].duration);
          // _controller.start();
        }
        return true;
      });

  @override
  Widget build(BuildContext context) {
    print('build');
    return FutureBuilder<dynamic>(
      future: callAsyncFetch(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        print(snapshot.data);
        if (snapshot.hasData && _stepsWidgetsList.isNotEmpty) {
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
                  tr('Programs.appBar')) as PreferredSizeWidget?,
              body: Container(
                color: Colors.yellow[100]!.withOpacity(0.3),
                child: PageView(
                  children: _stepsWidgetsList as List<Widget>,
                  pageSnapping: false,
                  physics:
                      CustomLockScrollPhysics(lockLeft: true, lockRight: true),
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: (index) {
                    //_controller.start();
                    onPageChanged(index);
                  },
                ),
              ),
              floatingActionButton: Visibility(
                visible: isVisibileNextBtn,
                child: FloatingActionButton.extended(
                  label: Text(
                    (_selectedScreenIndex + 1 >= _screens.length)
                        ? tr("General_DONE")
                        : tr("General_NEXT"),
                    style: const TextStyle(
                        fontFamily: 'Helvetica', fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(
                    Icons.star,
                    size: Theme.of(context).iconTheme.size! - 15,
                  ),
                  onPressed: nextPageOrBack,
                ),
              ),
            ),
          );
        } else {
          return Container(
            color: Colors.yellow[100],
            child: Center(
              child: Container(child: const CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}
