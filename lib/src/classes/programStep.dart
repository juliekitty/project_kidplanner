import 'dart:convert';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

import '../countdown_flutter/countdown_flutter.dart';

class ProgramStep {
  // Eigenschaften
  String /*!*/ id, picture, animation, userTitle;
  Duration /*!*/ duration;
  Widget? widget;
  bool done;
  int points;

  // Konstruktor
  ProgramStep(
      {this.id = '',
      this.duration = const Duration(minutes: 0),
      this.widget,
      this.picture = '',
      this.userTitle = '',
      this.animation = '',
      this.points = 0,
      this.done = false});

  factory ProgramStep.fromRawJson(String str) =>
      ProgramStep.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProgramStep.fromJson(Map<String, dynamic> json) => ProgramStep(
        id: json["id"],
        duration: globals.parseDuration(json['duration']),
        widget: json['widget'],
        picture: json["picture"],
        userTitle: json["userTitle"],
        animation: json['animation'],
        points: json['points'],
        done: json['done'].toLowerCase() == 'true',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        'duration': duration.toString(),
        'widget': widget,
        "picture": picture,
        "userTitle": userTitle,
        'animation': animation,
        'points': points,
        'done': done.toString(),
      };

  String displayDuration() {
    return duration.compareTo(const Duration(seconds: 0)) == 0
        ? '-'
        : '${duration.inMinutes}:'
            '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Widget displayGraphicalCountDown(context, _controller) {
    // _controller.start();
    return Stack(alignment: Alignment.center, children: [
      CircularCountDownTimer(
        duration: duration.inSeconds,
        initialDuration: 0,
        controller: _controller,
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.height / 4,
        ringColor: Colors.white,
        fillColor: Colors.cyan[500]!,
        backgroundColor: Colors.amber[800],
        strokeWidth: 10.0,
        strokeCap: StrokeCap.round,
        textStyle: const TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.S,
        isReverse: true,
        isReverseAnimation: true,
        isTimerTextShown: false,
        autoStart: true,
        onStart: () {
          // print('Countdown Started');
        },
        onComplete: () {
          // print('Countdown Ended');
        },
      ),
      displayCountdown(),
    ]);
  }

  Widget displayCountdown() {
    return Countdown(
      duration: duration,
      onFinish: () {
        // print('finished');
      },
      builder: (BuildContext ctx, Duration remaining) {
        return Text(
          '${remaining.inMinutes}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}',
          style: const TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
        );
      },
      key: UniqueKey(),
    );
  }

  String stepTitle() {
    if (userTitle.isNotEmpty) {
      return userTitle;
    } else if (id.isNotEmpty) {
      return tr('Programs.Steps.' + id);
    } else {
      return '';
    }
  }

  String stepDescription() {
    return tr('Programs.StepsDescription.' + id);
  }

// return a widget with step infos
  Widget stepDefault(context, _controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.amber,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
            child: Text(
              stepTitle(),
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
            child: displayGraphicalCountDown(context, _controller),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.height * 0.40,
              child: (picture != ''
                  ? SvgPicture.asset(picture, semanticsLabel: '')
                  : (Container())),
              // TODO display gif
            ),
          ),
        ]),
      ),
    );
  }

  Widget stepFinishedWidget(context, _controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.amber,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
            child: Text(
              stepTitle(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
            child: Text(
              stepDescription(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.60,
              height: MediaQuery.of(context).size.height * 0.60,
              child: (picture != ''
                  ? SvgPicture.asset(picture, semanticsLabel: '')
                  : (Container())),
              // TODO display gif
            ),
          ),
        ]),
      ),
    );
  }
}
