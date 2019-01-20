import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:glowing_guacamole/models/job_card.dart';
import 'package:glowing_guacamole/models/round_icon_button.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'dart:convert';
import 'dart:async';
import './models/job.dart';
// TODO: merge legacy.dart
// TODO: merge legacy2.dart
// TODO: add database_helper.dart

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext ctx) => new MyApp(),
        '/saved' : (BuildContext ctx) => new MyHomePage()/*,
        '/settings' : (BuildContext ctx) => new SettingsPage()*/
      },
      // theme: themeData,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  // TODO: api call to set job list here
  int _id = 0;
  String jL_company = "Facebook";
  String jL_location = "New York, NY";
  String jL_position = "Software Engineer, Intern/Co-op";
  String jL_description = "Code high-volume software using primarily C++ and Java, create web applications using primarily PHP, implement web interfaces using XHTML, CSS, and JavaScript, build report interfaces and data feeds";
  String jL_url = "https://www.facebook.com";
  
  // TODO: function to pop first in job list
  // sets variables to the value of next in array
  // if list is empty, set values to like error message saying to refresh
  void _nextjob() {
    setState(() {
        /* ... */
        _id++;
    });
  }
  void _savejob() {
    setState(() {
        /* ... */
        _id--;
    });
  }
  void _refreshjob() {
    setState(() {
        /* ... */
        _id = 0;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Job Search",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        // backgroundColor: Theme.of(ctx).accentColor,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: new IconButton(
          icon: new Icon(
            Icons.inbox,
            color: Colors.black,
          ),
          //onPressed: () => Navigator.push(ctx, SavedPage()),
          onPressed: () => Navigator.of(ctx).pushNamed('/saved'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: (){
              //Navigator.push(ctx, SettingsPage());
            },
          )
        ],
      ),
      
      // TODO: add card class and make it work with api
      // (can test with hard coded joblist before incorportating api)
      body: Container(
        color: Colors.white,
        child: JobCard(
          Job(
            "$jL_company$_id", 
            "$jL_location", 
            "$jL_position", 
            "$jL_description",
            "$jL_url",
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0.0,
        // TODO: LATER TASK: work out padding so it looks better maybe. it might be fine as is
        child: new Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            bottom: 16.0,
            left: 24.0,
            right: 24.0
          ),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new RoundIconButton.large(
                icon: Icons.clear,
                iconColor: Colors.red[500],
                onPressed: () {
                  _nextjob();// TODO: ignore job
                },
              ),
              new RoundIconButton.small(
                icon: Icons.refresh,
                iconColor: Colors.orange,
                onPressed: () {
                  _refreshjob();// TODO: refresh job list with api
                },
              ),
              new RoundIconButton.large(
                icon: Icons.favorite,
                iconColor: Colors.green[500],
                onPressed: () {
                  _savejob();// TODO: add job to database
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
