import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'database_helper.dart';
import 'todo_item.dart';

Future<DateTime?> showAddEditTodoDialogWithDate(BuildContext context, {TodoItem? existingTodo}) async {
  final TextEditingController titleController = TextEditingController(text: existingTodo?.title ?? '');
  final TextEditingController descriptionController = TextEditingController(text: existingTodo?.description ?? '');
  DateTime? pickedDate = existingTodo != null
      ? DateFormat('dd-MM-yyyy').parse(existingTodo.date)
      : DateTime.now();

  return await showDialog<DateTime?>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.yellow[500],
        title: Text(existingTodo == null ? 'Add Todo' : 'Edit Todo'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: "Description"),
              ),
              TextButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: pickedDate!,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != pickedDate) {
                    pickedDate = picked;
                  }
                },
                child: Text('Select Date: ${DateFormat('dd-MM-yyyy').format(pickedDate!)}'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () async {
              String title = titleController.text;
              String description = descriptionController.text;
              if (title.isNotEmpty && description.isNotEmpty) {
                TodoItem newTodo = TodoItem(
                  id: existingTodo?.id,
                  date: DateFormat('dd-MM-yyyy').format(pickedDate!),
                  title: title,
                  description: description,
                );
                if (existingTodo == null) {
                  await DatabaseHelper.instance.insertTodo(newTodo);
                } else {
                  await DatabaseHelper.instance.updateTodo(newTodo);
                }
                Navigator.of(context).pop(pickedDate); // Dismiss the dialog and return pickedDate
              }
            },
          ),
        ],
      );
    },
  );
}
