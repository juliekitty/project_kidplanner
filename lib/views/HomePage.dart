import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_kidplanner/views/advicesView.dart';
import 'package:project_kidplanner/views/bonusTasksView.dart';
import 'programView.dart';

Widget cardCarousel(
    {context,
    color,
    title,
    descrText,
    picture,
    route,
    arguments = '',
    buttonText}) {
  return AspectRatio(
    aspectRatio: 1 / 1.2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          color: color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (title != null ? title : 'Title'),
                style: Theme.of(context).textTheme.headline6,
              ),
              //Divider(),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text((descrText != null ? descrText : 'descrText')),
              ),
              //Divider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 100,
                  height: 100,
                  child: SvgPicture.asset(
                      (picture != null ? picture : 'assets/images/clock.svg'),
                      semanticsLabel: ''),
                ),
              ),
              //Divider(),
              route == null
                  ? new SizedBox()
                  : ElevatedButton(
                      child: Text(
                        (buttonText != null ? buttonText : 'GO'),
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => route,
                              settings: RouteSettings(
                                arguments: arguments,
                              ),
                            ));
                      },
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
    return ListView(
      scrollDirection: Axis.vertical, shrinkWrap: true,
      //physics: ScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
          child: Text(
            'Begin a routine',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                cardCarousel(
                    context: context,
                    color: Colors.yellow[600],
                    title: 'Morning Routine',
                    descrText: 'Begin your morning routine!',
                    picture: 'assets/images/clock.svg',
                    route: ProgramView(),
                    arguments: 'morning'),
                cardCarousel(
                    context: context,
                    color: Colors.cyan[200],
                    title: 'Bedtime Routine',
                    descrText: 'Begin your bedtime routine!',
                    picture: 'assets/images/wake-up.svg',
                    route: ProgramView(),
                    arguments: 'bedtime'),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
          child: Text(
            'Win bonus points',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                cardCarousel(
                  context: context,
                  color: Colors.cyan[200],
                  title: 'Planning advices',
                  descrText: 'Preparation is key!',
                  picture: 'assets/images/requirement.svg',
                  route: AdvicesView(),
                ),
                cardCarousel(
                  context: context,
                  color: Colors.orange,
                  title: 'Bonus Tasks',
                  descrText: 'Win bonus points!',
                  picture: 'assets/images/game-console.svg',
                  route: BonusTasksView(),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
          child: Text(
            'Play games',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                cardCarousel(
                    context: context,
                    color: Colors.cyan[200],
                    title: 'Games',
                    descrText: 'Redeem your rewards!',
                    picture: 'assets/images/game-console.svg'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
