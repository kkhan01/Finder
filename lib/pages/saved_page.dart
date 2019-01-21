import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  int _counter = 0;

  void _jobdel() {
    setState(() {
        _counter++;
    });
  }

  @override
  Widget build(BuildContext ctx) {
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
      
      // TODO: umm list out jobs from database, follow task manager as guide
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 32.0,
            right: 32.0,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Facebook",
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Software Engineer, Intern/Co-op",
                            style: TextStyle(
                              fontSize: 14.0, color: Colors.black
                            ),
                          ),
                        ],
                      )
                    ),
                    SizedBox(width: 6.0),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 36.0,
                      ),
                      onPressed: () {
                        // TODO: delete the saved job
                      },
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Uber",
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Product Designer, Uber Eats",
                            style: TextStyle(
                              fontSize: 14.0, color: Colors.black
                            ),
                          ),
                        ],
                      )
                    ),
                    SizedBox(width: 6.0),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 36.0,
                      ),
                      onPressed: () {
                        // TODO: delete the saved job
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}