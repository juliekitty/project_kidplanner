import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class ProgramStep {
  // Eigenschaften
  String title, picture, animation;
  Duration duration;
  Widget widget;
  bool done;
  int points;

  // Konstruktor
  ProgramStep(
      {this.title,
      this.duration,
      this.widget,
      this.picture,
      this.animation,
      this.points,
      this.done});

  String displayDuration() {
    return '${this.duration.inMinutes}:'
        '${(this.duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Widget displayGraphicalCountDown(context, _controller) {
    // _controller.start();
    return Stack(alignment: Alignment.center, children: [
      CircularCountDownTimer(
        duration: this.duration.inSeconds,
        initialDuration: 0,
        controller: _controller,
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.height / 4,
        ringColor: Colors.white,
        fillColor: Colors.cyan[500],
        backgroundColor: Colors.amber[800],
        strokeWidth: 10.0,
        strokeCap: StrokeCap.round,
        textStyle: TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.S,
        isReverse: true,
        isReverseAnimation: true,
        isTimerTextShown: false,
        autoStart: true,
        onStart: () {
          print('Countdown Started');
        },
        onComplete: () {
          print('Countdown Ended');
        },
      ),
      this.displayCountdown(),
    ]);
  }

  Widget displayCountdown() {
    return Countdown(
      duration: this.duration,
      onFinish: () {
        print('finished');
      },
      builder: (BuildContext ctx, Duration remaining) {
        return Text(
          '${remaining.inMinutes}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        );
      },
    );
  }

// return a widget with step infos
  Widget stepDefault(context, _controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Card(
        color: Colors.amber,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
            child: Text(
              this.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.all(10.0),
            child: this.displayCountdown(),
          ),*/
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: this.displayGraphicalCountDown(context, _controller),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.height * 0.40,
              child: (this.picture != null
                  ? SvgPicture.asset(this.picture, semanticsLabel: '')
                  : (Container())), // TODO display gif
            ),
          ),
        ]),
      ),
    );
  }
}
