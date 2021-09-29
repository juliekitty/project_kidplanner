import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_kidplanner/views/advicesView.dart';
import 'package:project_kidplanner/views/bonusTasksView.dart';
import 'package:project_kidplanner/views/programOverview.dart';
import 'package:project_kidplanner/views/snakeGame/game.dart';

Widget cardCarousel(
    {required context,
    color,
    title,
    descrText,
    picture,
    route,
    arguments = '',
    buttonText,
    costPoints}) {
  final snackBar = SnackBar(content: Text(tr('HP_SnackBar_NotEnoughPoints')));

  Future<dynamic> onTap() {
    if (costPoints != null) {
      if (globals.currentParticipant.score! - costPoints < 0) {
        // not enough points
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        return Future.delayed(Duration.zero, () {});
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

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Text(
                    (title ?? 'Title'),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.07),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  (descrText ?? 'descrText'),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                ),
              ), //
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 70,
                  height: 70,
                  child: SvgPicture.asset(
                      (picture ?? 'assets/images/clock.svg'),
                      semanticsLabel: ''),
                ),
              ),
              route == null
                  ? const SizedBox()
                  : ElevatedButton(
                      child: Text(
                        (buttonText ?? tr('General_go')),
                        style: const TextStyle(fontSize: 18),
                      ),
                      onPressed: onTap,
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
    var carouselConstraints = BoxConstraints(
      minHeight: 300, //minimum height
      minWidth: 300, // minimum width

      maxHeight: 350,
      //maximum height set to 100% of vertical height

      maxWidth: MediaQuery.of(context).size.width,
      //maximum width set to 100% of width
    );

    return ListView(
      scrollDirection: Axis.vertical, shrinkWrap: true,
      //physics: ScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
          child: Text(
            tr('HP_Carousel_Routines'),
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
          child: Container(
            constraints: carouselConstraints,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                cardCarousel(
                    context: context,
                    color: Colors.yellow[600],
                    title: tr('HP_Carousel_Routine_MorningTitle'),
                    descrText: tr('HP_Carousel_Routine_MorningDescr'),
                    picture: 'assets/images/clock.svg',
                    route: const ProgramView(),
                    arguments: 'morning'),
                cardCarousel(
                    context: context,
                    color: Colors.cyan[200],
                    title: tr('HP_Carousel_Routine_BedtimeTitle'),
                    descrText: tr('HP_Carousel_Routine_BedtimeDescr'),
                    picture: 'assets/images/wake-up.svg',
                    route: const ProgramView(),
                    arguments: 'bedtime'),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
          child: Text(
            tr('HP_Carousel_Bonus'),
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
          child: Container(
            constraints: carouselConstraints,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                cardCarousel(
                  context: context,
                  color: Colors.orange,
                  title: tr('HP_Carousel_Bonus_TasksTitle'),
                  descrText: tr('HP_Carousel_Bonus_TasksDescr'),
                  picture: 'assets/images/requirement.svg',
                  route: BonusTasksView(),
                ),
                cardCarousel(
                  context: context,
                  color: Colors.cyan[200],
                  title: tr('HP_Carousel_Bonus_AdvicesTitle'),
                  descrText: tr('HP_Carousel_Bonus_AdvicesDescr'),
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
            tr('HP_Carousel_Games'),
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 15, 5),
          child: Container(
            constraints: carouselConstraints,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                cardCarousel(
                    context: context,
                    color: Colors.cyan[200],
                    title: tr('HP_Carousel_Games_GamesTitle'),
                    descrText: tr('HP_Carousel_Games_GamesDescr'),
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
