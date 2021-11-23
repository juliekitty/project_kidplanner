import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/classes/user.dart';
import 'package:project_kidplanner/src/components/AlertDialogs.dart';
import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/components/bottomMenu.dart';
import 'package:project_kidplanner/src/components/fab.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;
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
    child: SizedBox(
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
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Text(
                  (title ?? 'Title'),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.07),
                  textAlign: TextAlign.center,
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
                child: SizedBox(
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _keyDialogForm = GlobalKey<FormState>();
  final Future _initFuture = Participant().currentUser();

  Future callAsyncFetch() => Future.delayed(Duration.zero, () {
        return _initFuture;
      });

  BoxConstraints carouselConstraints(context) {
    return BoxConstraints(
      minHeight: 300, //minimum height
      minWidth: 300, // minimum width

      maxHeight: 350,
      //maximum height set to 100% of vertical height

      maxWidth: MediaQuery.of(context).size.width,
      //maximum width set to 100% of width
    );
  }

  Widget returnProgramCarousel() {
    Participant user = Participant();
    List colors = [
      Colors.yellow[600],
      Colors.cyan[200],
      Colors.orange,
    ];
    return FutureBuilder(
        future: callAsyncFetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            dynamic data = snapshot.data;
            if (data != null) {
              user = data;
              globals.currentParticipant = user;

              // debugMode = (user.name == 'JulieTEMP');
              debugPrint('user data loaded ' + user.toString());
              final List<Program?>? participantPrograms = user.programs;

              return Container(
                  constraints: carouselConstraints(context),
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: <Widget>[
                        for (var program in participantPrograms!)
                          cardCarousel(
                              context: context,
                              color: colors[
                                  participantPrograms.indexOf(program) % 3],
                              title: tr(program!.title),
                              descrText: tr(program.descr),
                              picture: (program.picture != '')
                                  ? program.picture
                                  : 'assets/images/clock.svg',
                              route: const ProgramView(),
                              arguments: program.programId),
                      ]));
            } else {
              return Container(
                color: Colors.yellow[100],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          } else {
            return Container(
              color: Colors.yellow[100],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (globals.currentParticipant.name == null ||
          globals.currentParticipant.name == '') {
        AlertDialogs.askNameDialog(context, _keyDialogForm, setState);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        Theme.of(context).textTheme,
        tr('Countdown_PageTitle'),
      ) as PreferredSizeWidget?,
      extendBody: true,
      body: ListView(
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
            child: returnProgramCarousel(),
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
              constraints: carouselConstraints(context),
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
                    route: const BonusTasksView(),
                  ),
                  cardCarousel(
                    context: context,
                    color: Colors.cyan[200],
                    title: tr('HP_Carousel_Bonus_AdvicesTitle'),
                    descrText: tr('HP_Carousel_Bonus_AdvicesDescr'),
                    picture: 'assets/images/read.svg',
                    route: const AdvicesView(),
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
              constraints: carouselConstraints(context),
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
                      route: const GamePage(),
                      costPoints: 500),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: returnBottomNav(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: returnFab(context),
    );
  }
}
