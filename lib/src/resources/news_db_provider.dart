import 'cache.dart';
import 'source.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item.dart';

class NewsDbProvider implements Cache, Source{
  Database db;

  NewsDbProvider(){
    init();
  }

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE items(
            id INTEGER PRIMARY_KEY,
            deleted INTEGER,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            dead INTEGER,
            parent INTEGER,
            kids BLOB,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
        """);
      },
    );
  }

  Future<List<int>> fetchTopIds(){
    return null;
  }

  Future<Item> fetchItem(int id) async{
    final maps = await db.query(
      'items',
      columns: null, //['column_1', 'column_2'...] or null to fetch all
      where: "id = ?",
      whereArgs: [id],
    );

    return maps.length > 0 ? Item.fromDb(maps.first) : null;
  }

  Future<int> addItem(Item item){
    return db.insert('items', item.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> clear() async {
    return await db.delete('items');
  }
}

final newsDbProvider = NewsDbProvider();