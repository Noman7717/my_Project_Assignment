import 'package:api_call/sqflite_db/main.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'api_call/ApiScreen.dart';
import 'hive_db/main.dart';

class MainScreen extends StatelessWidget {
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApiScreen()),
                );
              },
              child: Text('Go to API Screen'),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow[300], // Set your desired color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Hivedb()),
                );
              },
              child: Text('Go to Hive Database'),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow[300], // Set your desired color
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sqfdatabase()),
                );
              },
              child: Text('Go to Sqflite Database'),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow[300], // Set your desired color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
