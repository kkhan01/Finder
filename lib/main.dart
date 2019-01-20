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
        '/home': (BuildContext context) => new MyApp(),
        '/saved' : (BuildContext context) => new SavedPage(),
        '/settings' : (BuildContext context) => new SettingsPage()
      },
      // theme: themeData,
  ));
}
