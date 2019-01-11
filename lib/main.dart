import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'dart:convert';
import 'dart:async';
import './models/job.dart';

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

void main() => runApp(MyApp());

// var apihelper = new APIHelper();
//   // Position, City, State
//   apihelper.searchJobs("Software Engineering Intern", "New York", "NY");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Job>>(
        future: fetchJobs(http.Client(), "intern", "New York", "NY"),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? JobsList(jobs: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
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
