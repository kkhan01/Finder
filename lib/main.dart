import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:glowing_guacamole/models/job_card.dart';
import 'package:glowing_guacamole/models/round_icon_button.dart';
import 'package:glowing_guacamole/pages/saved_page.dart';
import 'package:glowing_guacamole/pages/settings_page.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'dart:convert';
import 'dart:async';
import 'package:glowing_guacamole/models/job.dart';
import 'dart:developer';
// TODO: merge legacy.dart
// TODO: add database_helper.dart

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      routes: <String, WidgetBuilder> {
        '/home': (BuildContext ctx) => new MyApp(),
        '/saved' : (BuildContext ctx) => new SavedPage(),
        '/settings' : (BuildContext ctx) => new SettingsPage()
      },
      // theme: themeData,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  int _id = 0;
  
  List<Job> jL = [Job(
      "Oops!", 
      "Try hitting refresh ONCE!\n   (orange arrow below)\n    Then wait a second.", 
      "Possible Issues:",
      "1\) Internet connectivity failed.\n2\) Your settings did not make sense.\n3\) Offline sync ran out and we need to rescrape.\n4)\ You've saved every job we could scrape (try again later).",
      "https://www.google.com"
  )];

  Job currentJob = Job(
    "Oops!", 
    "Try hitting refresh ONCE!\n   (orange arrow below)\n    Then wait a second.", 
    "Possible Issues:",
    "1\) Internet connectivity failed.\n2\) Your settings did not make sense.\n3\) Offline sync ran out and we need to rescrape.\n4)\ You've saved every job we could scrape (try again later).",
    "https://www.google.com"
  );
  
  Future<void> _getjobs() async {
    jL = await fetchJobs(http.Client(), "intern", "New York", "NY");
    for (var i = 0; i < jL.length; i++){
      jL[i].description = _parseHtmlString(jL[i].description);
    }
    _setnext();
  }

  void _setnext() {
    setState(() {
        if(_id < 0){
          _id = 0;
        }else if(_id >= jL.length){
          _id = 0;
          jL = [Job(
              "Oops!", 
              "Try hitting refresh ONCE!\n   (orange arrow below)\n    Then wait a second.", 
              "Possible Issues:",
              "1\) Internet connectivity failed.\n2\) Your settings did not make sense.\n3\) Offline sync ran out and we need to rescrape.\n4)\ You've saved every job we could scrape (try again later).",
              "https://www.google.com"
          )];
        }
        currentJob = jL[_id];
    });
  }
  
  void _nextjob() {
    setState(() {
        _id++;
        _setnext();
    });
  }
  void _savejob() {
    setState(() {
        // TODO: add job to database
        _id++;
        _setnext();
    });
  }
  Future<void> _refreshjob() async {
    await _getjobs();
    setState(() {
        _id = -1;
        _setnext();
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
          onPressed: () => Navigator.of(ctx).pushNamed('/saved'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: (){
              Navigator.of(ctx).pushNamed('/settings');
            },
          )
        ],
      ),
      
      body: Container(
        color: Colors.white,
        child: JobCard(
          currentJob
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0.0,
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


String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

Future<List<Job>> fetchJobs(
  http.Client client, String position, String state, String city) async {
  List<Job> jobs = List<Job>();
  final String pos = position.replaceAll(new RegExp(r' '), ',');
  final String API_KEY = '';
  final String url =
  'https://authenticjobs.com/api/?api_key=${API_KEY}&method=aj.jobs.search&keywords=${pos}&location=${city}, ${state}&perpage=20&format=json';

  final response = await client.get(url);
  return compute(parseJobs, response.body);
}

List<Job> parseJobs(String responseBody) {
  final parsed = json.decode(responseBody);
  return parsed['listings']['listing']
  .map<Job>((json) => new Job.fromJson(json))
  .toList();
}

class JobsList extends StatelessWidget {
  final List<Job> jobs;

  JobsList({Key key, this.jobs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobs.length,
      itemExtent: 2500,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Text(jobs[index].company),
            Text(jobs[index].location),
            Text(jobs[index].position),
            Text(_parseHtmlString(jobs[index].description)),
            Text(jobs[index].url),
          ],
        );
      },
    );
  }
}

