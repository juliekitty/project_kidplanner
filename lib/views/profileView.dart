import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/user.dart';

import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;
import 'package:project_kidplanner/views/creditsView.dart';

const profileListPadding = EdgeInsets.fromLTRB(15.0, 12.5, 25.0, 12.5);

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future _initFuture = Participant().currentUser();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Participant user = snapshot.data;
            user.programs = globals.defaultPrograms;
            globals.currentParticipant = user;

            return Scaffold(
              appBar: appBar(context, Theme.of(context).textTheme, 'Profile'),
              body: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: profileListPadding,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: Icon(Icons.person)),
                            Expanded(flex: 1, child: Divider()),
                            Expanded(
                                flex: 10,
                                child:
                                    Text(user.name == null ? '' : user.name)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: globals.profileListBoxDecoration,
                        padding: profileListPadding,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 10, child: Text('Current score:')),
                            Expanded(flex: 1, child: Divider()),
                            Expanded(
                                flex: 10, child: Text(user.score.toString())),
                          ],
                        ),
                      ),
                      Container(
                        decoration: globals.profileListBoxDecoration,
                        padding: profileListPadding,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 10, child: Text('Your programs:')),
                            Expanded(flex: 1, child: Divider()),
                            Expanded(
                                flex: 10,
                                child: Text(user.programs.toString())),
                          ],
                        ),
                      ),
                      Container(
                        decoration: globals.profileListBoxDecoration,
                        padding: profileListPadding,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 10, child: Text('Debug:')),
                            Expanded(flex: 1, child: Divider()),
                            Expanded(
                                flex: 10,
                                child: ElevatedButton(
                                  child: Text('Add 500'),
                                  onPressed: () {
                                    setState(() {
                                      user.addToScore(500);
                                    });
                                  },
                                )),
                          ],
                        ),
                      ),
                      Container(
                        decoration: globals.profileListBoxDecoration,
                        padding: profileListPadding,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(child: Text('Credits')),
                                IconButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_right,
                                    size: Theme.of(context).iconTheme.size,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreditsRoute()),
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container(
              color: Colors.yellow[100],
              child: Center(
                child: Container(child: CircularProgressIndicator()),
              ),
            );
          }
        });
  }
}
