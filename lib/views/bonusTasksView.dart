import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../src/components/appBar.dart';

class BonusTasksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//
    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme, 'Bonus Tasks'),
      body: Text('Bonus Tasks'),
    );
  }
}
