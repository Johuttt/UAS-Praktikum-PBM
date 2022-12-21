// ignore_for_file: unused_field

import 'package:app/kontak.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    return _database = await _initializeDb();
  }

  static const String _tableName = 'kontaks';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'kontak_db.db'),
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, nama TEXT, nomor TEXT)''');
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertKontak(Kontak kontak) async {
    final Database db = await database;
    await db.insert(
      _tableName,
      kontak.toMap(),
    );
  }

  Future<List<Kontak>> getKontaks() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(_tableName);

    return result.map((res) => Kontak.fromMap(res)).toList();
  }

  Future<void> deleteKontak(int id) async {
    final Database db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateKontak(Kontak kontak) async {
    final Database db = await database;
    await db.update(_tableName, kontak.toMap(),
        where: 'id = ?', whereArgs: [kontak.id]);
  }
}
