import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist.dart';
import 'package:flutter/foundation.dart';

class TVWatchlistNotifier extends ChangeNotifier {
  var _watchlistTVs = <TV>[];
  List<TV> get watchlistMovies => _watchlistTVs;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  TVWatchlistNotifier({required this.getWatchlistTVs});

  final GetTVWatchlist getWatchlistTVs;

  Future<void> fetchWatchlistTVs() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTVs.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTVs = tvsData;
        notifyListeners();
      },
    );
  }
}
