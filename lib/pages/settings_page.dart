import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _counter = 0;

  void _savesettings() {
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
          "SETTINGS",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.black,
            ),
            onPressed: (){
              // TODO: save settings method called here, are we using another db? we should use a json or smth....
              Navigator.popUntil(ctx, ModalRoute.withName(Navigator.defaultRouteName));
            },
          )
        ],
      ),
      
      // TODO: form for api search
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 32.0,
            right: 32.0,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                // controller: positionController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  labelText: "Position",
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  hintText: "Software Engineer",
                ),
              ),
              TextField(
                // controller: positionController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.location_city,
                    color: Colors.black,
                  ),
                  labelText: "City",
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  hintText: "New York",
                ),
              ),
              // TODO: need to implement DropDownButton
            ],
          ),
        )
      ),
    );
  }
}
