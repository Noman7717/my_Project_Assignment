import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'todo_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo_app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        title TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> insertTodo(TodoItem todo) async {
    Database db = await database;
    return await db.insert('todos', todo.toMap());
  }

  Future<List<TodoItem>> getTodos() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return TodoItem.fromMap(maps[i]);
    });
  }

  Future<int> updateTodo(TodoItem todo) async {
    Database db = await database;
    return db.update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(int id) async {
    Database db = await database;
    return db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
