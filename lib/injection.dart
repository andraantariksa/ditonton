import 'dart:io';

import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_on_the_air_tvs.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_tvs.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie_watchlist_notifier.dart';
import 'package:ditonton/presentation/provider/movies_popular_notifier.dart';
import 'package:ditonton/presentation/provider/movies_top_rated_notifier.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_watchlist_notifier.dart';
import 'package:ditonton/presentation/provider/tvs_popular_notifier.dart';
import 'package:ditonton/presentation/provider/tvs_top_rated_notifier.dart';
import 'package:ditonton/utils/secured_network_context.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TVListNotifier(
      getOnTheAirTVs: locator(),
          getPopularTVs: locator(),
          getTopRatedTVs: locator(),
        ),
  );
  locator.registerFactory(
        () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
        () => TVDetailNotifier(
      getTVDetail: locator(),
      getTVRecommendations: locator(),
      getTVWatchListStatus: locator(),
      saveTVWatchlist: locator(),
      removeTVWatchlist: locator(),
    ),
  );
  locator.registerFactory(
        () => TVSearchNotifier(
      searchTVs: locator(),
    ),
  );
  locator.registerFactory(
        () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => TVsPopularNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MoviesPopularNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TVsTopRatedNotifier(
      getTopRatedTVs: locator(),
    ),
  );
  locator.registerFactory(
        () => MoviesTopRatedNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => TVWatchlistNotifier(
      getWatchlistTVs: locator(),
    ),
  );
  locator.registerFactory(
        () => MovieWatchlistNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetMovieWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => GetMovieWatchlist(locator()));

  locator.registerLazySingleton(() => GetOnTheAirTVs(locator()));
  locator.registerLazySingleton(() => GetPopularTVs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVs(locator()));
  locator.registerLazySingleton(() => GetTVDetail(locator()));
  locator.registerLazySingleton(() => GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVs(locator()));
  locator.registerLazySingleton(() => GetTVWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveTVWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTVWatchlist(locator()));
  locator.registerLazySingleton(() => GetTVWatchlist(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TVRepository>(
        () => TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVRemoteDataSource>(
      () => TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVLocalDataSource>(
      () => TVLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  var networkContext = await securedNetworkContext();
  locator.registerLazySingleton<http.Client>(
      () => IOClient(HttpClient(context: networkContext)));
}
