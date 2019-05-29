
import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unisinos_events/events/event.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Event(id INTEGER PRIMARY KEY, title TEXT, description TEXT, date TEXT)");
  }

  Future<int> saveEvent(Event event) async {
    var dbClient = await db;
    int res = await dbClient.insert("Event", event.toMap());
    return res;
  }

  Future<List<Event>> getEvent() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Event');
    List<Event> events = new List();
    for (int i = 0; i < list.length; i++) {
      var event = 
          new Event(title: list[i]["title"], description: list[i]["description"], date: list[i]["date"]);
      event.setEventId(list[i]["id"]);
      events.add(event);
    }
    print(events.length);
    return events;
  }
}