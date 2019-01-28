import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';

import 'dart:async';

import 'package:glowing_guacamole/utils/database_helper.dart';

import 'package:glowing_guacamole/models/job.dart';

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
	List<Job> jobList;
  int count = 0;

  @override
  Widget build(BuildContext ctx) {

    if (jobList == null) {
			jobList = List<Job>();
			updateListView();
    }
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "SAVED",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check, 
              color: Colors.black
            ),
            onPressed: () {
              Navigator.popUntil(ctx, ModalRoute.withName(Navigator.defaultRouteName));
            },
          )
        ],
      ),
      
      body: getJobListView(),

    );
  }

  ListView getJobListView() {

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext ctx, int index) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 16.0,
            right: 16.0
          ),
          child: Card(
            color: Colors.white,
					elevation: 2.0,
					child: ListTile(
              title: Text(this.jobList[index].company,),
              subtitle: Text(this.jobList[index].position),
              trailing: GestureDetector(
							child: Icon(Icons.delete_outline),
							onTap: () {
								_delete(ctx, jobList[index]);
							},
              ),
              
            ),
          ),
        );
      }
    );
  }

  void _delete(BuildContext ctx, Job job) async {

		int result = await databaseHelper.deleteJob(job.id);
		if (result != 0) {
			_showSnackBar(ctx, 'Job Deleted Successfully');
			updateListView();
		}
	}

	void _showSnackBar(BuildContext ctx, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(ctx).showSnackBar(snackBar);
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			  Future<List<Job>> jobListFuture = databaseHelper.getJobList();
			  jobListFuture.then((jobList) {
				    setState(() {
				        this.jobList = jobList;
				        this.count = jobList.length;
				    });
			  });
		});
  }

}



