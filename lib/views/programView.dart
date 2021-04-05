import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../src/components/appBar.dart';

import 'package:project_kidplanner/src/classes/program.dart';
import 'package:project_kidplanner/src/libraries/programsData.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'programDetails.dart';
import 'package:flutter/rendering.dart';

//import 'package:project_kidplanner/src/components/DurationExtension.dart';
//
String displayDuration(Duration duration) {
  return '${duration.inMinutes}:'
      '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
}

class ProgramView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String programType = ModalRoute.of(context).settings.arguments;
//
    //print('ok ${programs.toString()}');
    final Program program = findProgramUsingFirstWhere(programs, programType);

    Widget createTile(context, step) {
      return Card(
        color: Colors.amber,
        child: GestureDetector(
          onTap: () {
            /*Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoDetailsRoute(),
              settings: RouteSettings(
                arguments: photo,
              ),
            ),
          );*/
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.40,
            height: MediaQuery.of(context).size.height * 1,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    step.title.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: SvgPicture.asset(
                          (step.picture != null
                              ? step.picture
                              : 'assets/images/clock.svg'),
                          semanticsLabel: ''),
                    ),
                  ),
                  Text(displayDuration(step.duration)),
                ]),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme, 'Program'),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '${program.title}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Duration ${displayDuration(program.getDuration())}\n\n'
                'There are ${program.steps.length} steps',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              for (var item in program.steps)
                RichText(
                  text: TextSpan(
                    text: '• ',
                    style: Theme.of(context).textTheme.bodyText2,
                    children: <TextSpan>[
                      TextSpan(
                        text: '${item.title.toString()}',
                      ),
                    ],
                  ),
                ),
            ]),
          ),
          program.steps.length == 0
              ? new SizedBox()
              : SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    children: [
                      for (var item in program.steps) createTile(context, item)
                    ],
                  ),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.keyboard_arrow_right),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProgramDetailsView(),
              settings: RouteSettings(
                arguments: program.programId,
              ),
            ),
          );
        },
      ),
/*
ElevatedButton(
                      child: Text(
                        (buttonText != null ? buttonText : 'GO'),
                        style: TextStyle(fontSize: 18),
                      ),
                      
                    ),
*/
    );
  }
}
