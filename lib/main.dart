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
        initialRoute: '/',
        routes: {
          '/': (context) => LayoutView(),
          '/profile': (context) => ProfileView(),
          '/CountDownTimer': (context) => CountDownTimer(),
          '/Advices': (context) => AdvicesView(),
          '/BonusTasksView': (context) => BonusTasksView(),
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
  final Future _initFuture = Init.initialize();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return HomePage();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
