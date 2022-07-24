import 'dart:async';

import 'package:ditonton/data/models/movie_overview_table.dart';
import 'package:ditonton/data/models/tv_overview_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblTVWatchlist = 'tv_watchlist';
  static const String _tblMovieWatchlist = 'movie_watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblMovieWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
      
      CREATE TABLE  $_tblTVWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertTVWatchlist(TVOverviewTable movie) async {
    final db = await database;
    return await db!.insert(_tblTVWatchlist, movie.toJson());
  }

  Future<int> removeTVWatchlist(TVOverviewTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblTVWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getTVById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTVWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTVs() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblMovieWatchlist);

    return results;
  }

  Future<int> insertMovieWatchlist(MovieOverviewTable movie) async {
    final db = await database;
    return await db!.insert(_tblMovieWatchlist, movie.toJson());
  }

  Future<int> removeMovieWatchlist(MovieOverviewTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblMovieWatchlist);

    return results;
  }
}
