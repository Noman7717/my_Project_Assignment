import 'package:flutter/material.dart';
import 'todo_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const sqfdatabase());
}

class sqfdatabase extends StatelessWidget {
  const sqfdatabase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo APP',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.yellow[300],
      ),
      home: const TodoListPage(),
    );
  }
}
