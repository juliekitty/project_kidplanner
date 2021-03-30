import 'package:flutter/material.dart';
//import 'CountDownState.dart';
import 'views/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        //primaryColor: Colors.lightBlue[800],
        //accentColor: Colors.cyan[600],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        fontFamily: 'Futura',
        /*textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),*/
      ),

      //typography:
    );
  }
}
