import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'todo_item.dart';
import 'add_edit_todo_dialog.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<TodoItem> todos = [];

  @override
  void initState() {
    super.initState();
    _refreshTodoList();
  }

  Future<void> _refreshTodoList() async {
    todos = await DatabaseHelper.instance.getTodos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.yellow[600],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildTodoItem(context, todos[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showAddEditTodoDialog(context);
          await _refreshTodoList(); // Refresh the list after the dialog is closed
        },
        backgroundColor: Colors.yellow[800],
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoItem(BuildContext context, TodoItem todo) {
    return Card(
      color: Colors.yellow[600],
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 5),
            Text(
              'Date: ${todo.date}',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        onTap: () async {
          await _showAddEditTodoDialog(context, todo);
          await _refreshTodoList(); // Refresh the list after the dialog is closed
        },
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.yellow[900]),
          onPressed: () => _confirmDeleteDialog(context, todo.id),
        ),
      ),
    );
  }

  Future<void> _showAddEditTodoDialog(BuildContext context, [TodoItem? todo]) async {
    final result = await showAddEditTodoDialogWithDate(context, existingTodo: todo);
    if (result != null && result is DateTime) {
      return;
    }
  }

  Future<void> _confirmDeleteDialog(BuildContext context, int? todoId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.yellow[400],
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                await _deleteTodoItem(todoId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTodoItem(int? todoId) async {
    if (todoId != null) {
      await DatabaseHelper.instance.deleteTodo(todoId);
      await _refreshTodoList(); // Refresh the list after deleting the item
    }
  }
}
