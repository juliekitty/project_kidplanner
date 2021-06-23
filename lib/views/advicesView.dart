import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

class AdvicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var maxIndex = 0;
    return Scaffold(
      appBar:
          appBar(context, Theme.of(context).textTheme, tr('Advices_PageTitle')) as PreferredSizeWidget?,
      body: Container(
        color: Colors.yellow[100]!.withOpacity(0.3),
        child: PageView(
            onPageChanged: (index) {
              if (maxIndex < index) {
                globals.currentParticipant.addToScore(50);
                maxIndex = index;
              }
            },
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.amber,
                  child: Center(
                    child: Text(
                      'Advices',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.amber,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 3),
                      child: Text(
                        'Limit Keepsakes',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Some children let go of things easily, but for those who are stubborn about saving every little thing, offer up a "limiting container".',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
                      child: Image.asset(
                        'assets/images/advices/1.jpg',
                        height: 200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'They can keep all of the keepsakes they want, as long as they fit in a certain box, or on a certain shelf.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.amber,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
                      child: Text(
                        'Stick to a Routine',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'It helps to deliberately verbalize the steps of your morning and evening routines with kids. Post a checklist on a bathroom mirror or bedroom wall for things like packing lunch, gathering homework, and getting dressed. Bedtime habits are important to emphasize because they pave a smoother path to sleep.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
                      child: Image.asset(
                        'assets/images/advices/2.jpg',
                        height: 200,
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.amber,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
                      child: Text(
                        'Ask for Kids\' Help',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Let kids feel empowered by having them help you plan your errands before leaving the house. Have them help solve the puzzle of pinpointing the fastest route around town — and note logistical roadblocks, like making sure frozen food doesn\'t melt or pets won\'t be left in the car. Make it interesting with a stop for frozen yogurt as a reward.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
                      child: Image.asset(
                        'assets/images/advices/3.jpg',
                        height: 200,
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.amber,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
                      child: Text(
                        'Give Toys a Clear Value',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'The A-B-C-D prioritization tool works for everything: \n\nAn "A" toy is a favorite one that you love and play with all the time (as often as you eat or brush our teeth). \n"B" toys are ones you play with a lot (as often as we go to the supermarket). \n"C" toys are those you don\'t play with very much (as often as we have a birthday or holiday). \n"D" toys are ones you really are not playing with at all. And D stands for "donate!" \n\nShow kids that we want to store our A and B toys where we can reach them and put them away easily, and our C toys up higher in a box or on a shelf.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.amber,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
                      child: Text(
                        'Use Lists',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'You can make packing lists for kids when you are going on a trip, or have them help you make shopping and to-do lists. Kids love to cross things off and you\'re teaching them how to organize their thoughts. Lists can also be helpful for reducing your need to nag when there are several tasks that need to be done.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
                      child: Image.asset(
                        'assets/images/advices/4.jpg',
                        height: 200,
                      ),
                    ),
                  ]),
                ),
              ),
            ]),
      ),
    );
  }
}
