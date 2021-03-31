import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../src/components/appBar.dart';
import 'creditsView.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, Theme.of(context).textTheme, 'Profile'),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.person),
                  Expanded(
                      child: Text(
                          'Name Name Name Name Name Name Name Name Name ')),
                ],
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Hint Text',
                    //helperText: 'Helper Text',
                    //counterText: '0 characters',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.circular(6.0),
                  border: const Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.0),
                    top: BorderSide(color: Colors.grey, width: 0.0),
                    left: BorderSide(color: Colors.grey, width: 0.0),
                    right: BorderSide(color: Colors.grey, width: 0.0),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(15.0, 12.5, 25.0, 12.5),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(child: Text('Content')),
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
                    new Row(children: [Container()]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
