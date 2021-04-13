import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;
import 'package:project_kidplanner/generated/l10n.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_kidplanner/views/advicesView.dart';
import 'package:project_kidplanner/views/bonusTasksView.dart';
import 'package:project_kidplanner/views/programView.dart';
import 'package:project_kidplanner/views/snakeGame/game.dart';

Widget cardCarousel(
    {context,
    color,
    title,
    descrText,
    picture,
    route,
    arguments = '',
    buttonText,
    costPoints}) {
  final snackBar =
      SnackBar(content: Text(S.of(context).HPSnackBarNotEnoughPoints));

  Future<dynamic> onTap() {
    if (costPoints != null) {
      if (globals.currentParticipant.score - costPoints < 0) {
        // not enough points
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        return new Future.delayed(Duration.zero, () {});
      } else {
        globals.currentParticipant.addToScore(-costPoints);
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => route,
            settings: RouteSettings(
              arguments: arguments,
            ),
          ),
        );
      }
    } else {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => route,
          settings: RouteSettings(
            arguments: arguments,
          ),
        ),
      );
    }
  }

  return AspectRatio(
    aspectRatio: 1 / 1.2,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            color: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    (title != null ? title : 'Title'),
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text((descrText != null ? descrText : 'descrText')),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 70,
                    height: 70,
                    child: SvgPicture.asset(
                        (picture != null ? picture : 'assets/images/clock.svg'),
                        semanticsLabel: ''),
                  ),
                ),
                route == null
                    ? new SizedBox()
                    : ElevatedButton(
                        child: Text(
                          (buttonText != null
                              ? buttonText
                              : S.of(context).general_go),
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: onTap,
                      ),
              ],
            ),
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
            S.of(context).HP_Carousel_Routines,
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
                    title: S.of(context).HP_Carousel_Routine_MorningTitle,
                    descrText: S.of(context).HP_Carousel_Routine_MorningDescr,
                    picture: 'assets/images/clock.svg',
                    route: ProgramView(),
                    arguments: 'morning'),
                cardCarousel(
                    context: context,
                    color: Colors.cyan[200],
                    title: S.of(context).HP_Carousel_Routine_BedtimeTitle,
                    descrText: S.of(context).HP_Carousel_Routine_BedtimeDescr,
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
            S.of(context).HP_Carousel_Bonus,
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
                  color: Colors.orange,
                  title: S.of(context).HP_Carousel_Bonus_TasksTitle,
                  descrText: S.of(context).HP_Carousel_Bonus_TasksDescr,
                  picture: 'assets/images/requirement.svg',
                  route: BonusTasksView(),
                ),
                cardCarousel(
                  context: context,
                  color: Colors.cyan[200],
                  title: S.of(context).HP_Carousel_Bonus_AdvicesTitle,
                  descrText: S.of(context).HP_Carousel_Bonus_AdvicesDescr,
                  picture: 'assets/images/read.svg',
                  route: AdvicesView(),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
          child: Text(
            S.of(context).HP_Carousel_Games,
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
                    title: S.of(context).HP_Carousel_Games_GamesTitle,
                    descrText: S.of(context).HP_Carousel_Games_GamesDescr,
                    picture: 'assets/images/game-console.svg',
                    route: GamePage(),
                    costPoints: 500),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
