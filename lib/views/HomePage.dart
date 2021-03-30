import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'programView.dart';
import '../src/components/bottomMenu.dart';
import '../src/components/fab.dart';
import '../src/components/appBar.dart';

Widget cardCarousel({context, color, title, descrText, picture}) {
  return AspectRatio(
    aspectRatio: 1 / 2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          color: color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (title != null ? title : 'Title'),
                style: Theme.of(context).textTheme.headline5,
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text((descrText != null ? descrText : 'descrText')),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 200,
                  height: 200,
                  child: SvgPicture.asset(
                      (picture != null ? picture : 'assets/images/clock.svg'),
                      semanticsLabel: ''),
                ),
              ),
              Divider(),
              /*ElevatedButton(
                onPressed: () {
                  print('pressed');
                },
                child: Text('GO'),
              ),*/

              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 100, height: 100),
                child: ElevatedButton(
                  child: Text(
                    'GO',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProgramView()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, Theme.of(context).textTheme, ''),
        body:
            /*Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [*/
            /*Padding(
            padding: const EdgeInsets.fromLTRB(8, 50, 8, 8),
            child: Container(
              //color: Theme.of(context).accentColor,
              child: Text(
                'What do you want to do now?',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),*/
            /*Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 500.0,
            child: */
            ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            cardCarousel(
                context: context,
                color: Colors.yellow[600],
                title: 'Morning Routine',
                descrText: 'Begin your morning routine!',
                picture: 'assets/images/clock.svg'),
            cardCarousel(
                context: context,
                color: Colors.cyan[200],
                title: 'Bedtime Routine',
                descrText: 'Begin your bedtime routine!',
                picture: 'assets/images/wake-up.svg'),
            cardCarousel(
                context: context,
                color: Colors.orange,
                title: 'Planning advices',
                descrText: 'Preparation is key!',
                picture: 'assets/images/requirement.svg'),
            cardCarousel(
                context: context,
                color: Colors.cyan[600],
                title: 'Games',
                descrText: 'Redeem your rewards and play games!',
                picture: 'assets/images/game-console.svg'),
          ],
        ),
        /*),*/
        /*Text(
            'caption',
            textAlign: TextAlign.center,
            style: textTheme.caption,
          ),*/
        /*],
      ),*/
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: returnFab(context),
        bottomNavigationBar: returnBottomNav(context));
  }
}
