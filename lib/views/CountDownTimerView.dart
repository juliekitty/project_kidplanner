import 'package:audioplayers/audioplayers.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({Key? key}) : super(key: key);

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;
  Duration resultingDuration = const Duration(hours: 0, minutes: 0);

  // Audio
  static AudioCache player = AudioCache(
      prefix: globals.audioFilesPrefix, fixedPlayer: globals.audioPlayer);

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Future initDuration() async {
    var resultingDuration = await showDurationPicker(
      context: context,
      initialTime: const Duration(minutes: 3),
      snapToMins: 5.0,
    );
    setState(() {
      controller.duration =
          (resultingDuration == null) ? Duration.zero : resultingDuration;
    });
    startTimer();
  }

  void startTimer() {
    setState(() {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
    });
  }

  void stopTimer() {
    setState(() {
      controller.stop();
    });
  }

  void timerFinished() {
    player.play(globals.timerFinishedAudio);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Scaffold(
            appBar: appBar(
              context,
              Theme.of(context).textTheme,
              tr('Countdown_PageTitle'),
            ) as PreferredSizeWidget?,
            extendBody: true,
            body: Container(
              color: Colors.yellow[100]!.withOpacity(0.3),
              child: Stack(
                children: <Widget>[
                  controller.duration != Duration.zero
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                          child: Center(
                            child: Column(children: [
                              Text(
                                tr('Countdown_PageIntroText'),
                                style: const TextStyle(fontSize: 18),
                              ),
                              ElevatedButton(
                                child: Text(
                                  tr('Countdown_SetTimerButtonLabel'),
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                onPressed: initDuration,
                              ),
                            ]),
                          ),
                        ),
                  controller.duration == Duration.zero
                      ? Container()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.amber[800],
                            height: controller.value *
                                MediaQuery.of(context).size.height,
                          ),
                        ),
                  controller.duration == Duration.zero
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Align(
                                  alignment: FractionalOffset.center,
                                  child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: FractionalOffset.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                tr('Countdown_PageTitle'),
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.cyan[200]),
                                              ),
                                              Text(
                                                timerString,
                                                style: TextStyle(
                                                    fontSize: 112.0,
                                                    color: Colors.cyan[200]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: AnimatedBuilder(
                                    animation: controller,
                                    builder: (context, child) {
                                      return IconButton(
                                        color: Colors.cyan[200],
                                        iconSize: 60,
                                        onPressed: () {
                                          if (controller.isAnimating) {
                                            stopTimer();
                                          } else {
                                            startTimer();
                                          }
                                        },
                                        icon: Icon(controller.isAnimating
                                            ? Icons.pause
                                            : Icons.play_arrow),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }
}
