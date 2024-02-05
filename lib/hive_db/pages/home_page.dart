import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:api_call/hive_db/data/database.dart';
import 'package:api_call/hive_db/pages/todo_tiles.dart';
import 'package:api_call/hive_db/pages/dialogBox.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    //if 1st time open create default data
    if (_myBox.get("TODOLIST")==null) {
      db.createInitialData();
    } else
    {
    //if there is already data available
    db.loadData();
    }

    super.initState();
  }

  // reference hive box
  final _myBox =Hive.box('mybox');
  ToDoDataBase db =ToDoDataBase();

  //text controller
  final _controller=TextEditingController();



//checkbox was tapped
  void checkedBoxChanged(bool? value, int index) {
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
    });
    db.updateDatabase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.ToDoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateDatabase();
  }


//create a new task
  void createNewTask() {
    showDialog(context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),

          );
        },);
    db.updateDatabase();
  }

//delete task
  void deleteTask(int index) {
    setState(() {
      db.ToDoList.removeAt(index);
    });
    db.updateDatabase();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text(
          "TO DO APP",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow[700],

      ),
      body: ListView.builder(
        itemCount: db.ToDoList.length,
        itemBuilder: (context, index) {
          return ToDoList(
              taskName: db.ToDoList[index][0],
              taskCompleted: db.ToDoList[index][1],
              onChanged: (value) => checkedBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
