import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// defaults
String appBarTitle = '';

Widget appBar(context, textTheme, appBarTitle) {
  return AppBar(
    title: Text(
      (appBarTitle != '' ? appBarTitle : 'Routine for Kids'),
      style: textTheme.headline6
          .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.more_horiz),
        tooltip: 'Contact',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Une personne a été ajoutée.'),
              duration: Duration(seconds: 2, milliseconds: 500),
            ),
          );
        },
      ),
    ],
  );
}
