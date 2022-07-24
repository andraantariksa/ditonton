import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getNowPlayingMovies();
  Future<Either<Failure, List<TV>>> getPopularMovies();
  Future<Either<Failure, List<TV>>> getTopRatedMovies();
  Future<Either<Failure, TVDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<TV>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlist(TVDetail movie);
  Future<Either<Failure, String>> removeWatchlist(TVDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TV>>> getWatchlistMovies();
}
