import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:project_kidplanner/src/classes/user.dart';
import 'package:project_kidplanner/src/components/AlertDialogs.dart';
import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;
import 'package:project_kidplanner/views/HomePage.dart';
import 'package:project_kidplanner/views/creditsView.dart';
import 'package:project_kidplanner/views/profile/programList.dart';

const profileListPadding = EdgeInsets.fromLTRB(15.0, 12.5, 25.0, 12.5);

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with AlertDialogs {
  final Future _initFuture = Participant().currentUser();
  bool debugMode = false;
  final GlobalKey<FormState> _keyDialogForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    debugPrint('initState verifyParentDialog');
    Future.delayed(Duration.zero, () {
      return AlertDialogs.verifyParentDialog(context, _keyDialogForm, setState);
    });
  }

  Future callAsyncFetch() => Future.delayed(Duration.zero, () {
        return _initFuture;
      });

  @override
  Widget build(BuildContext context) {
    Participant user = Participant();

    var participantList = Participant.getAllParticipants();

    return FutureBuilder(
        future: callAsyncFetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            dynamic data = snapshot.data;
            if (data != null) {
              user = data;
              globals.currentParticipant = user;

              debugMode = (user.name == 'JulieTEMP');
              // print(user);
            }
            return Scaffold(
              appBar: appBar(
                context,
                Theme.of(context).textTheme,
                tr('Profile_PageTitle'),
              ) as PreferredSizeWidget?,
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
                            const Expanded(flex: 1, child: Icon(Icons.person)),
                            const Expanded(flex: 1, child: Divider()),
                            Expanded(
                                flex: 10,
                                child:
                                    Text(user.name == null ? '' : user.name!)),
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
                            Expanded(
                                flex: 10,
                                child: Text(tr('Profile_Points_label'))),
                            const Expanded(flex: 1, child: Divider()),
                            Expanded(
                                flex: 10, child: Text(user.score.toString())),
                          ],
                        ),
                      ),
                      if (debugMode)
                        Container(
                          decoration: globals.profileListDebugBoxDecoration,
                          padding: profileListPadding,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child:
                                          const Text('Profile_Programs_label')
                                              .tr()),
                                  IconButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_right,
                                      size: Theme.of(context).iconTheme.size,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ProgramListView(),
                                          settings: RouteSettings(
                                            arguments: user,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (debugMode)
                        Container(
                          decoration: globals.profileListDebugBoxDecoration,
                          padding: profileListPadding,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 10,
                                  child:
                                      const Text('Profile_Debug_label').tr()),
                              const Expanded(flex: 1, child: Divider()),
                              Expanded(
                                  flex: 10,
                                  child: ElevatedButton(
                                    child: Text(tr(
                                        'Profile_Debug_addPointsButtonlabel')),
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
                                Expanded(
                                    child: const Text('Profile_Credits_label')
                                        .tr()),
                                IconButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_right,
                                    size: Theme.of(context).iconTheme.size,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreditsRoute()),
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (debugMode)
                        Container(
                          decoration: globals.profileListDebugBoxDecoration,
                          padding: profileListPadding,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 10,
                                  child: Text(tr('Profile_Language_label'))),
                              const Expanded(flex: 1, child: Divider()),
                              Expanded(
                                  flex: 10,
                                  child:
                                      Text(Intl.getCurrentLocale().toString())),
                            ],
                          ),
                        ),
                      if (debugMode)
                        Container(
                          decoration: globals.profileListDebugBoxDecoration,
                          padding: profileListPadding,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: const Text('Profile_Logout').tr()),
                                  IconButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_right,
                                      size: Theme.of(context).iconTheme.size,
                                    ),
                                    onPressed: () {
                                      globals.currentParticipant.name == '';
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage(),
                                          settings: RouteSettings(
                                            arguments: user,
                                          ),
                                        ),
                                      );

                                      //
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      if (debugMode)
                        Container(
                          decoration: globals.profileListDebugBoxDecoration,
                          padding: profileListPadding,
                          child: Text(participantList.toString()),
                        ),
                    ],
                  ),
                ],
              ),
            );
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
}
