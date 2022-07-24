import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_overview_table.dart';

abstract class TVLocalDataSource {
  Future<String> insertWatchlist(TVOverviewTable movie);
  Future<String> removeWatchlist(TVOverviewTable movie);
  Future<TVOverviewTable?> getTVById(int id);
  Future<List<TVOverviewTable>> getWatchlistTVs();
}

class TVLocalDataSourceImpl implements TVLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TVOverviewTable?> getTVById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return TVOverviewTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TVOverviewTable>> getWatchlistTVs() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => TVOverviewTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TVOverviewTable tv) async {
    try {
      await databaseHelper.insertTVWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TVOverviewTable tv) async {
    try {
      await databaseHelper.removeTVWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

}