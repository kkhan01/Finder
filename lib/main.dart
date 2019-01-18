/*
SEARCH FOR "TODO" for tasks

LINKS:
General Design: https://whimsical.co/2jbY96yxpqqDxoeaLKFHDk

Three page: https://www.youtube.com/watch?v=b2fgMCeSNpY
Tinder-esque: https://www.youtube.com/watch?v=NMHhzd5ewP4

Task Manager: https://github.com/jiachangyang1025/flutter-sqflite-todo-app
Database: 
https://github.com/smartherd/Flutter-Demos
https://www.youtube.com/watch?v=1BwjNEKD8g8&index=25&list=PLlxmoA0rQ-Lw6tAs2fGFuXGP13-dWdKsB
Misc Demo: https://github.com/rahulkp220/Learning-Flutter
Published app: https://github.com/FrazileDevelopers/Wallfy
Flutter Studio: http://mutisya.com/
*/

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'dart:convert';
import 'dart:async';
import './models/job.dart';
// TODO: merge legacy.dart
// TODO: add database_helper.dart


void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      theme: themeData,
  ));
}

// TODO: LATER TASK: choose theme colors
final ThemeData themeData = ThemeData(
  canvasColor: Colors.limeAccent[700],
  accentColor: Colors.lightGreen[900],
);

class MyApp extends StatelessWidget {
  
  Widget _buildBottomBar() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0.0,
      // TODO: LATER TASK: work out padding so it looks better maybe. it might be fine as is
      child: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new RoundIconButton.large(
              icon: Icons.clear,
              iconColor: Colors.red,
              onPressed: () {
                // TODO: ignore job
              },
            ),
            new RoundIconButton.small(
              icon: Icons.refresh,
              iconColor: Colors.orange,
              onPressed: () {
                // TODO: refresh job list with api
              },
            ),
            new RoundIconButton.large(
              icon: Icons.favorite,
              iconColor: Colors.green,
              onPressed: () {
                // TODO: add job to database
              },
            ),
          ],
        ),
      ),
    );
  }
  
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
      
      // TODO: add card class and make it work with api
      // (can test with hard coded joblist before incorportating api)
      body: Center(
        child: FlatButton(
          onPressed: (){
            Navigator.push(ctx, PageTwo());
          },
          child: Text("Go to Page Two"),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
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
        
        // TODO: umm list out jobs from database, follow task manager as guide
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
                // TODO: save settings method called here, are we using another db? we should use a json or smth....
                Navigator.popUntil(ctx, ModalRoute.withName(Navigator.defaultRouteName));
              },
            )
          ],
        ),
        
        // TODO: form for api search
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

class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final VoidCallback onPressed;

  RoundIconButton.large({
      this.icon,
      this.iconColor,
      this.onPressed,
  }) : size = 70.0;

  RoundIconButton.small({
      this.icon,
      this.iconColor,
      this.onPressed,
  }) : size = 50.0;

  RoundIconButton({
      this.icon,
      this.iconColor,
      this.size,
      this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: size,
      height: size,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          new BoxShadow(
            color: const Color(0x11000000),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: new RawMaterialButton(
        shape: new CircleBorder(),
        elevation: 0.0,
        child: new Icon(
          icon,
          color: iconColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
