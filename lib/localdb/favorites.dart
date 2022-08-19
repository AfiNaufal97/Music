import 'dart:io';

import 'package:music_apps/model/favotestdb.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Favorites {
  String _dbName = 'local.db';
  int _versionDb = 1;

  // table
  String table = 'favorite';
  String id = 'id';
  String title = 'title';
  String artist = 'artist';
  String url = 'url';

  Database? _database;

  Future<Database?> database() async {
    if (_database != null) return _database;
    _database = await _initDatabse();
    return _database;
  }

  Future _initDatabse() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return openDatabase(path, onCreate: _onCreate, version: _versionDb);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table($id INTEGER PRIMARY KEY, $title TEXT, $artist TEXT, $url TEXT)');
  }

  // show all
  Future<List<FavoritesDB>> getAllFav() async {
    final data = await _database!.query(table);
    List<FavoritesDB> list = data.map((e) => FavoritesDB.fromJson(e)).toList();
    return list;
  }

  // insert fav
  Future<int> insert(Map<String, dynamic> data) async {
    bool isAlready = await checkData(data);
    if (isAlready) {
      print("gagal");
      return 0;
    } else {
      final result = await _database!.insert(table, data);
      print(result);
      return result;
    }
  }

  // query by FavoriteDB
  Future<FavoritesDB?> search(FavoritesDB favoritesDB) async {
    final result = await _database!.query(table,
        columns: [id, title, artist, url],
        where: '$title = ?',
        whereArgs: [favoritesDB.title]);
    if (result.length > 0) {
      return FavoritesDB.fromJson(result.first);
    }
    return null;
  }

  // cek data
  Future<bool> checkData(Map<String, dynamic> data) async {
    var result = await getAllFav();
    if (result.isEmpty) {
      return false;
    } else {
      var dataResult =
          result.map((e) => e.title == data['title']).toList().contains(true);
      return dataResult;
    }
  }

  // getMusic
  Future<FavoritesDB> getMusic(String ttile)async{
      var result = await _database?.query(table, where: '$title = ?', whereArgs: [title]);
      return FavoritesDB.fromJson(result!.first);
  }

  // delete
  Future<int> deleteBYid(int id)async{
    print('delete $id');
    return await _database!.delete(table, where: '$id = ?', whereArgs: [id]);
  }
}
