import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'CountDownTimerView.dart';

class CountDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Countdown(
      duration: Duration(seconds: 10),
      onFinish: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CountDownTimer()),
        );
      },
      builder: (BuildContext ctx, Duration remaining) {
        return Text(
          '${remaining.inMinutes}:${remaining.inSeconds}',
          style:
              TextStyle(color: Colors.black, decoration: TextDecoration.none),
        );
      },
    );
  }
}
