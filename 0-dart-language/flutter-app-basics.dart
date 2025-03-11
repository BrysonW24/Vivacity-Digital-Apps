// Basic App Building Examples - Structured for Flutter & Web App Development
// This repository contains fundamental Flutter app-building concepts.

// Each file will be a separate module covering key app-building examples.

//==========================================//

// Basic App Building Examples - Table of Contents
// 21_counter_app.dart - A basic counter app demonstrating setState()
// 22_todo_app.dart - Simple To-Do list using ListView and TextField
// 23_api_request_app.dart - Making HTTP requests using the http package
// 24_local_storage.dart - Storing data locally using shared_preferences
// 25_database_sqlite.dart - Basic CRUD operations with SQLite

//==========================================//

// 21_counter_app.dart - A basic counter app demonstrating setState()
import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Counter App')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Counter: \$_counter', style: TextStyle(fontSize: 24)),
              ElevatedButton(onPressed: _incrementCounter, child: const Text('Increment')),
            ],
          ),
        ),
      ),
    );
  }
}

// 22_todo_app.dart - Simple To-Do list using ListView and TextField
class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<String> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    setState(() {
      _tasks.add(_controller.text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('To-Do List')),
        body: Column(
          children: [
            TextField(controller: _controller, decoration: const InputDecoration(labelText: 'Enter task')),
            ElevatedButton(onPressed: _addTask, child: const Text('Add Task')),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) => ListTile(title: Text(_tasks[index]))
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 23_api_request_app.dart - Making HTTP requests using the http package
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIExample extends StatefulWidget {
  const APIExample({super.key});

  @override
  _APIExampleState createState() => _APIExampleState();
}

class _APIExampleState extends State<APIExample> {
  String data = 'Fetching...';

  void fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body)['title'];
      });
    } else {
      setState(() {
        data = 'Failed to load data';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('API Request Example')),
        body: Center(child: Text(data)),
      ),
    );
  }
}

// 24_local_storage.dart - Storing data locally using shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

class StorageExample extends StatefulWidget {
  const StorageExample({super.key});

  @override
  _StorageExampleState createState() => _StorageExampleState();
}

class _StorageExampleState extends State<StorageExample> {
  String _storedValue = 'No Data';

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('key', 'Hello Flutter!');
    _loadData();
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = prefs.getString('key') ?? 'No Data';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Local Storage Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Stored Data: $_storedValue', style: TextStyle(fontSize: 18)),
              ElevatedButton(onPressed: _saveData, child: const Text('Save Data')),
            ],
          ),
        ),
      ),
    );
  }
}

// 25_database_sqlite.dart - Basic CRUD operations with SQLite
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), 'example.db'),
    onCreate: (db, version) {
      return db.execute('CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT)');
    },
    version: 1,
  );
}

Future<void> insertItem(String name) async {
  final db = await getDatabase();
  await db.insert('items', {'name': name}, conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map<String, dynamic>>> fetchItems() async {
  final db = await getDatabase();
  return db.query('items');
}

// Main function to test components
void main() {
  runApp(const CounterApp());
}
 
