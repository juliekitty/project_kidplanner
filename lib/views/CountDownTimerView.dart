import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/rendering.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;
import 'package:project_kidplanner/generated/l10n.dart';

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;
  Duration resultingDuration = Duration(hours: 0, minutes: 0);

  // Audio
  static AudioCache player = new AudioCache(
      prefix: globals.audioFilesPrefix, fixedPlayer: globals.audioPlayer);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Future initDuration() async {
    var resultingDuration = await showDurationPicker(
      context: context,
      initialTime: Duration(minutes: 3),
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
          return Stack(
            children: <Widget>[
              controller.duration != Duration.zero
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                      child: Center(
                        child: Column(children: [
                          Text(
                            S.of(context).Countdown_PageIntroText,
                            style: TextStyle(fontSize: 18),
                          ),
                          ElevatedButton(
                            child: Text(
                              S.of(context).Countdown_SetTimerButtonLabel,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                      padding: EdgeInsets.all(8.0),
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
                                            S.of(context).Countdown_PageTitle,
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
          );
        });
  }
}
