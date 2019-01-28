import 'package:flutter/material.dart';
import 'package:glowing_guacamole/models/job.dart';

class JobCard extends StatelessWidget {
  final Job job;

  JobCard(this.job);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
            elevation: 0.0,
            child: ListView(
              children: <Widget>[
                Center(
                  child: FittedBox(
                    child: Text(
                      job.company,
                      style: TextStyle(
                        fontSize: 64.0, // NEEDS TO ADJUST
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      job.location,
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Divider(
                    color: Colors.black,
                    height: 32.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    job.position,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    job.description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}