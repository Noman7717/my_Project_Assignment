import 'package:api_call/sqflite_db/main.dart';
import 'package:flutter/material.dart';
import 'api_call/ApiScreen.dart';
import 'hive_db/main.dart';
class MainScreen extends StatelessWidget {
  ListTile buildListTile(BuildContext context, String buttonText, Widget destination) {
    return ListTile(
      title: Container(
        height: 50, // Set a fixed height for all ListTiles
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
          child: Text(buttonText),
          style: ElevatedButton.styleFrom(
            primary: Colors.yellow[300],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[400],
      appBar: AppBar(
        title: Text('Main Screen'),
        backgroundColor: Colors.yellow[700],
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildListTile(context, 'Go to API Screen', ApiScreen()),
            buildListTile(context, 'Go to Hive Database', Hivedb()),
            buildListTile(context, 'Go to Sqflite Database', sqfdatabase()),
          ],
        ),
      ),
    );
  }
}
