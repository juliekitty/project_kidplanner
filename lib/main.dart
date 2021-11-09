import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_kidplanner/src/classes/user.dart';
import 'package:project_kidplanner/src/libraries/globals.dart' as globals;

import 'package:easy_localization/easy_localization.dart';

import 'package:project_kidplanner/src/classes/init.dart';

import 'package:project_kidplanner/views/HomePage.dart';
import 'package:project_kidplanner/views/profileView.dart';
import 'package:project_kidplanner/views/CountDownTimerView.dart';
import 'package:project_kidplanner/views/advicesView.dart';
import 'package:project_kidplanner/views/bonusTasksView.dart';
import 'package:project_kidplanner/views/splashScreenView.dart';

import 'package:project_kidplanner/src/components/appBar.dart';
import 'package:project_kidplanner/src/components/fab.dart';
import 'package:project_kidplanner/src/components/bottomMenu.dart';
import 'package:project_kidplanner/src/components/AlertDialogs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // forbid rotation to Landscape mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    EasyLocalization(
        // ignore: prefer_const_literals_to_create_immutables
        supportedLocales: [const Locale('en'), const Locale('fr')],
        path: 'lib/l10n', // <-- change the path of the translation files
        fallbackLocale: const Locale('en'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future _initFuture = Init.initialize();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      primarySwatch: Colors.cyan,
      iconTheme: IconThemeData(
        color: Colors.cyan[600],
        size: 40,
      ),
      primaryIconTheme: const IconThemeData(
        color: Colors.white,
        size: 40,
      ),
      //buttonTheme: ButtonThemeData(),
      fontFamily: 'Futura',
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 28.0),
        bodyText1: TextStyle(fontSize: 18.0),
        bodyText2: TextStyle(fontSize: 18.0),
      ),
    );

    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: FutureBuilder(
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const LayoutView();
            } else {
              return SplashScreen();
            }
          },
        ),
        routes: {
          '/profile': (context) => ProfileView(),
        },
        debugShowCheckedModeBanner: false,
        theme: theme);
  }
}

class LayoutView extends StatefulWidget {
  const LayoutView({Key? key}) : super(key: key);

  @override
  _LayoutViewState createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": HomePage(), "title": tr('General_appName')},
    {"screen": CountDownTimer(), "title": tr('Countdown_PageTitle')},
    {"screen": ProfileView(), "title": tr('Profile_PageTitle')},
    {"screen": AdvicesView(), "title": tr('Advices_PageTitle')},
    {"screen": BonusTasksView(), "title": tr('Bonus_PageTitle')}
  ];

  final GlobalKey<FormState> _keyDialogForm = GlobalKey<FormState>();

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

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme,
          _screens[_selectedScreenIndex]["title"]) as PreferredSizeWidget?,
      body: Container(
        color: Colors.yellow[100]!.withOpacity(0.3),
        child: _screens[_selectedScreenIndex]["screen"],
      ),
      extendBody: true,
      bottomNavigationBar: returnBottomNav(_selectedScreenIndex, _selectScreen),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: returnFab(context),
    );
  }
}
