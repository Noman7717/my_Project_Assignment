import 'package:hive/hive.dart';

class ToDoDataBase{

  List ToDoList=[];


  //reference the box
  final _myBox = Hive.box('mybox');

  //run if this is 1st time ever opening this app
  void createInitialData() {
    ToDoList = [
    ["Namaz", false],
    ["Coding", false],
    ];
  }

  //load data from database
  void loadData(){
    ToDoList = _myBox.get("TODOLIST");
  }

  //update the database
  void updateDatabase(){
    _myBox.put("TODOLIST", ToDoList);
  }

}