import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/models/job.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String jobTable = 'job_table';
	String colId = 'id';
	String colCompany = 'company';
	String colLocation = 'location';
	String colPosition = 'position';
  String colDescription = 'description';
  String colUrl = 'url';

  factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
  }

  Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
  }

  Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'jobs.db';

		// Open/create the database at a given path
		var jobsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return jobsDatabase;
  }


  
}
