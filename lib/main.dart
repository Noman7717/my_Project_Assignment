import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'MainScreen.dart';

void main() async {
  //initialize hive
  await Hive.initFlutter();

  //opening the box
  var box = await Hive.openBox('mybox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment NIC',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MainScreen(),
    );
  }
}
