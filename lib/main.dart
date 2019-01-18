import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'dart:convert';
import 'dart:async';
import './models/job.dart';

/*
LINKS:
General Design: https://whimsical.co/2jbY96yxpqqDxoeaLKFHDk

Three page: https://www.youtube.com/watch?v=b2fgMCeSNpY
Tinder-esque: https://www.youtube.com/watch?v=NMHhzd5ewP4

Task Manager: https://github.com/jiachangyang1025/flutter-sqflite-todo-app
Database: https://github.com/smartherd/Flutter-Demos
Misc Demo: https://github.com/rahulkp220/Learning-Flutter
Published app: https://github.com/FrazileDevelopers/Wallfy
Flutter Studio: http://mutisya.com/
*/


void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      theme: themeData,
  ));
}

final ThemeData themeData = ThemeData(
  canvasColor: Colors.grey[50],
  accentColor: Colors.deepPurple,
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Job Search"),
        backgroundColor: Theme.of(ctx).accentColor,
        elevation: 2.0,
        leading: new IconButton(
          icon: new Icon(Icons.inbox),
          onPressed: () => Navigator.push(ctx, PageTwo()),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.build),
            onPressed: (){
              Navigator.push(ctx, PageThree());
            },
          )
        ],
      ),
      body: Center(
        child: FlatButton(
          onPressed: (){
            Navigator.push(ctx, PageTwo());
          },
          child: Text("Go to Page Two"),
        ),
      ),
    );
  }
}

class PageTwo extends MaterialPageRoute<Null> {
  PageTwo() : super(builder: (BuildContext ctx) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("SAVED"),
          backgroundColor: Theme.of(ctx).accentColor,
          elevation: 2.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check, color:Theme.of(ctx).accentColor)
            )
          ],
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                ctx,
                PageThree()
              );
            },
            child: Text("Go to Page Three"),
          ),
        ),
      );
  });
}

class PageThree extends MaterialPageRoute<Null> {
  PageThree() : super(builder: (BuildContext ctx) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("SETTINGS"),
          backgroundColor: Theme.of(ctx).accentColor,
          elevation: 2.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: (){
                // save method here
                Navigator.popUntil(ctx, ModalRoute.withName(Navigator.defaultRouteName));
              },
            )
          ],
        ),
        body: Center(
          child: MaterialButton(
            onPressed: (){
              Navigator.popUntil(ctx, ModalRoute.withName(Navigator.defaultRouteName));
            },
            child: Text("Go Home!"),
          ),
        ),
      );
  });

}


/* Button Icons:
Icons.check
Icons.build
Icons.keyboard_arrow_left
Icons.inbox
Icons.done_all
*/
