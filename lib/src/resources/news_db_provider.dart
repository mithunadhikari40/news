import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import 'package:news/src/models/news_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final String path = join(directory.path, 'news.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        print(db);
        newDb.execute("""

        CREATE TABLE Items
        (
          id INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          parent INTEGER,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTEGER,
          deleted INTEGER,
          dead INTEGER,
          kids BLOB
        )
        
        """);
      },
    );
  }

  Future<int> addItem(NewsModel model) {
    return db.insert('Items', model.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<NewsModel> fetchItem(int id) async {
    final data = await db.query(
      "Items",
      // columns: null,
      columns: ["*"],
      where: "id = ?",
      whereArgs: [id],
    );

    if (data.length > 0) {
      return NewsModel.fromDb(data.first);
    }
    return null;
  }

  @override
  Future<List<int>> fetchTopStories() {
    return null;
  }

  @override
 Future<int> clearCache() {
    return db.delete('Items');
  }
}

final NewsDbProvider dbProvider = NewsDbProvider();
