import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_overview_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieOverviewTable movie);
  Future<String> removeWatchlist(MovieOverviewTable movie);
  Future<MovieOverviewTable?> getMovieById(int id);
  Future<List<MovieOverviewTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieOverviewTable movie) async {
    try {
      await databaseHelper.insertMovieWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieOverviewTable movie) async {
    try {
      await databaseHelper.removeMovieWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieOverviewTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieOverviewTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieOverviewTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieOverviewTable.fromMap(data)).toList();
  }
}
